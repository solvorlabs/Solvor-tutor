import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/l10n/strings_provider.dart';
import '../../../../ai/edge/intent_classifier.dart';
import '../../../../ai/ocr/ocr_service.dart';
import '../../../../ai/paraphrase/explanation_paraphraser.dart';
import '../../../../ai/search/offline_search.dart';
import '../ai_tutor_provider.dart';

class AiTutorScreen extends ConsumerStatefulWidget {
  const AiTutorScreen({super.key});

  @override
  ConsumerState<AiTutorScreen> createState() => _AiTutorScreenState();
}

class _AiTutorScreenState extends ConsumerState<AiTutorScreen> {
  final _controller = TextEditingController();
  final _ocrService = OcrService();
  final _picker = ImagePicker();
  String _query = '';
  bool _ocrProcessing = false;

  void _submit() {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    setState(() => _query = q);
  }

  Future<void> _captureAndOcr() async {
    setState(() => _ocrProcessing = true);
    try {
      final xFile = await _picker.pickImage(source: ImageSource.camera);
      if (xFile == null) return;

      final file = File(xFile.path);
      final text = await _ocrService.extractText(file);
      if (text.trim().isNotEmpty) {
        _controller.text = text.trim();
        _submit();
      }
    } finally {
      if (mounted) setState(() => _ocrProcessing = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(langProvider);
    final searchAsync = ref.watch(aiTutorSearchProvider(_query));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: Text(AppStrings.get('home_ai_tutor', lang)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: AppStrings.get('ai_tutor_hint', lang),
                prefixIcon: _ocrProcessing
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: _captureAndOcr,
                      ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _submit,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
          Expanded(
            child: searchAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (state) {
                if (_query.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.get('ai_tutor_empty', lang),
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                if (!state.hasResults) {
                  if (state.intent != IntentType.unknown) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _IntentBadge(label: state.intentLabel),
                          const SizedBox(height: 16),
                          Text(
                            AppStrings.get('ai_tutor_rephrase', lang),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      AppStrings.get('ai_tutor_rephrase', lang),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    if (state.intent != IntentType.unknown)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _IntentBadge(label: state.intentLabel),
                      ),
                    ...state.results
                        .take(3)
                        .map((r) => _ResultCard(result: r)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IntentBadge extends StatelessWidget {
  final String label;
  const _IntentBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome,
              size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatefulWidget {
  final SearchResult result;
  const _ResultCard({required this.result});

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard> {
  bool _expanded = false;
  ParaphraseMode _paraphraseMode = ParaphraseMode.short;
  final _paraphraser = ExplanationParaphraser();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => setState(() => _expanded = !_expanded),
            title: Text(
              widget.result.questionText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Relevance: ${widget.result.relevanceScore.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            trailing: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Explanation:',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      _ParaphraseToggle(
                        mode: _paraphraseMode,
                        onChanged: (m) =>
                            setState(() => _paraphraseMode = m),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _paraphraser.paraphrase(
                      widget.result.explanationText,
                      mode: _paraphraseMode,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ParaphraseToggle extends StatelessWidget {
  final ParaphraseMode mode;
  final ValueChanged<ParaphraseMode> onChanged;
  const _ParaphraseToggle({required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => onChanged(ParaphraseMode.short),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: mode == ParaphraseMode.short
                  ? (isDark ? Colors.white24 : Colors.black12)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Short', style: TextStyle(fontSize: 12, fontWeight: mode == ParaphraseMode.short ? FontWeight.bold : FontWeight.normal)),
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => onChanged(ParaphraseMode.simplified),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: mode == ParaphraseMode.simplified
                  ? (isDark ? Colors.white24 : Colors.black12)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Simple', style: TextStyle(fontSize: 12, fontWeight: mode == ParaphraseMode.simplified ? FontWeight.bold : FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}
