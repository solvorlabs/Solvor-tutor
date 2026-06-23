import 'package:flutter/material.dart';
import '../../../../core/theme/design_tokens.dart';

class ExplanationCard extends StatefulWidget {
  final String questionText;
  final List<String> options;
  final int correctOption;
  final int? selectedOption;
  final bool isCorrect;
  final String explanation;
  final String? shortcutFormulaNote;
  final String? commonMistakeNote;
  final String? subjectTag;
  final VoidCallback? onAddToNotebook;
  final bool showAddToNotebook;

  const ExplanationCard({
    super.key,
    required this.questionText,
    required this.options,
    required this.correctOption,
    this.selectedOption,
    required this.isCorrect,
    required this.explanation,
    this.shortcutFormulaNote,
    this.commonMistakeNote,
    this.subjectTag,
    this.onAddToNotebook,
    this.showAddToNotebook = false,
  });

  @override
  State<ExplanationCard> createState() => _ExplanationCardState();
}

class _ExplanationCardState extends State<ExplanationCard> {
  bool _expanded = false;
  bool _addedToNotebook = false;

  static const _neonRed = Color(0xFFFF4444);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = widget.isCorrect ? kNeonTeal : _neonRed;
    final lightAccent = widget.isCorrect ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? kSurface : Colors.white,
        border: Border.all(color: isDark ? kSubtle : kBorder),
      ),
      child: Stack(
        children: [
          // 3px left accent bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 3,
              color: isDark ? accent : lightAccent,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header row — always visible
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                  child: Row(
                    children: [
                      // correct/wrong icon
                      Container(
                        width: 28,
                        height: 28,
                        color: isDark ? accent.withValues(alpha: 0.15) : lightAccent.withValues(alpha: 0.12),
                        child: Icon(
                          widget.isCorrect ? Icons.check : Icons.close,
                          size: 16,
                          color: isDark ? accent : lightAccent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.questionText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : kInk,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.isCorrect ? 'Correct' : 'Wrong',
                              style: TextStyle(
                                color: isDark ? accent : lightAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _expanded ? Icons.expand_less : Icons.expand_more,
                        size: 18,
                        color: isDark ? Colors.white38 : kMuted,
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded detail
              if (_expanded) ...[
                Container(height: 1, color: isDark ? kSubtle : kBorder),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Answer comparison
                      _AnswerLine(
                        label: 'YOUR ANSWER',
                        value: _answerLabel(widget.selectedOption),
                        color: isDark ? accent : lightAccent,
                      ),
                      const SizedBox(height: 6),
                      _AnswerLine(
                        label: 'CORRECT ANSWER',
                        value: _answerLabel(widget.correctOption),
                        color: kNeonTeal,
                      ),
                      const SizedBox(height: 14),

                      // Explanation
                      Text(
                        'EXPLANATION',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                          color: isDark ? Colors.white38 : kMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.explanation,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : kInk.withValues(alpha: 0.85),
                          height: 1.55,
                        ),
                      ),

                      // Shortcut note
                      if (widget.shortcutFormulaNote != null) ...[
                        const SizedBox(height: 12),
                        _NoteBlock(
                          icon: Icons.lightbulb_outline,
                          text: widget.shortcutFormulaNote!,
                          accentColor: kNeonTeal,
                          isDark: isDark,
                        ),
                      ],

                      // Common mistake note
                      if (widget.commonMistakeNote != null) ...[
                        const SizedBox(height: 8),
                        _NoteBlock(
                          icon: Icons.warning_amber_outlined,
                          text: widget.commonMistakeNote!,
                          accentColor: kNeonYellow,
                          isDark: isDark,
                        ),
                      ],

                      // Add to Notebook button
                      if (widget.showAddToNotebook && !widget.isCorrect) ...[
                        const SizedBox(height: 14),
                        GestureDetector(
                          onTap: _addedToNotebook
                              ? null
                              : () {
                                  widget.onAddToNotebook?.call();
                                  setState(() => _addedToNotebook = true);
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            color: _addedToNotebook
                                ? (isDark ? kSubtle : kBorder)
                                : (isDark ? kNeonTeal : kInk),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _addedToNotebook
                                      ? Icons.check
                                      : Icons.bookmark_add_outlined,
                                  size: 16,
                                  color: _addedToNotebook
                                      ? (isDark ? Colors.white38 : kMuted)
                                      : (isDark ? Colors.black : Colors.white),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _addedToNotebook
                                      ? 'ADDED TO NOTEBOOK'
                                      : 'ADD TO NOTEBOOK',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: _addedToNotebook
                                        ? (isDark ? Colors.white38 : kMuted)
                                        : (isDark ? Colors.black : Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _answerLabel(int? index) {
    if (index == null || index < 0 || index >= widget.options.length) {
      return 'Not answered';
    }
    final labels = ['A', 'B', 'C', 'D'];
    return '${labels[index]}. ${widget.options[index]}';
  }
}

class _AnswerLine extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _AnswerLine({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: color.withValues(alpha: 0.7),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _NoteBlock extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color accentColor;
  final bool isDark;

  const _NoteBlock({
    required this.icon,
    required this.text,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: isDark ? 0.08 : 0.06),
        border: Border(
          left: BorderSide(color: accentColor, width: 2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: accentColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isDark ? accentColor.withValues(alpha: 0.9) : Colors.black87,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
