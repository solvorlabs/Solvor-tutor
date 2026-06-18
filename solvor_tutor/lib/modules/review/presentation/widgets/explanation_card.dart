import 'dart:convert';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: widget.isCorrect ? Colors.green[200]! : Colors.red[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            onTap: () => setState(() => _expanded = !_expanded),
            leading: CircleAvatar(
              backgroundColor:
                  widget.isCorrect ? Colors.green[100] : Colors.red[100],
              child: Icon(
                widget.isCorrect ? Icons.check_circle : Icons.cancel,
                color: widget.isCorrect ? Colors.green : Colors.red,
              ),
            ),
            title: Text(
              widget.questionText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              widget.isCorrect ? 'Correct' : 'Wrong',
              style: TextStyle(
                color: widget.isCorrect ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your answer: ${_answerLabel(widget.selectedOption)}',
                    style: TextStyle(
                      color: widget.isCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Correct answer: ${_answerLabel(widget.correctOption)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Explanation:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.explanation),
                  if (widget.shortcutFormulaNote != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb,
                              size: 18, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.shortcutFormulaNote!,
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (widget.commonMistakeNote != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.warning_amber,
                              size: 18, color: Colors.orange[700]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.commonMistakeNote!,
                              style: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (widget.showAddToNotebook && !widget.isCorrect)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: OutlinedButton.icon(
                        onPressed: widget.onAddToNotebook,
                        icon: const Icon(Icons.bookmark_add, size: 18),
                        label: const Text('Add to Notebook'),
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

  String _answerLabel(int? index) {
    if (index == null || index < 0 || index >= widget.options.length) {
      return 'Not answered';
    }
    final labels = ['A', 'B', 'C', 'D'];
    return '${labels[index]}. ${widget.options[index]}';
  }
}
