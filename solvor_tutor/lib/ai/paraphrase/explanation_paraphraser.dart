import 'dart:math' as math;

enum ParaphraseMode { short, simplified }

class ExplanationParaphraser {
  String paraphrase(String text,
      {ParaphraseMode mode = ParaphraseMode.short, String language = 'en'}) {
    if (text.isEmpty) return '';
    switch (mode) {
      case ParaphraseMode.short:
        return _shorten(text, language);
      case ParaphraseMode.simplified:
        return _simplify(text, language);
    }
  }

  String _shorten(String text, String language) {
    final sentences = _splitSentences(text);
    if (sentences.length <= 1) return text;

    if (language == 'hi') {
      final idx = sentences.indexWhere((s) =>
          s.contains('तो') ||
          s.contains('इसलिए') ||
          s.contains('अतः') ||
          s.contains('उत्तर') ||
          s.contains('अर्थ'));
      if (idx > 0 && idx < sentences.length) {
        return sentences.sublist(idx).join(' ');
      }
    } else {
      final idx = sentences.indexWhere((s) => _resultWords.any((w) {
            final lower = s.toLowerCase();
            return lower.contains(w);
          }));
      if (idx > 0 && idx < sentences.length) {
        return sentences.sublist(idx).join(' ');
      }
    }

    final first = sentences.first.trim();
    if (first.length > 25) return first;
    return text;
  }

  String _simplify(String text, String language) {
    if (language == 'hi') return text;

    var result = text;
    for (final e in _replacements.entries) {
      result = result.replaceAllMapped(
        RegExp('\\b${RegExp.escape(e.key)}\\b', caseSensitive: false),
        (_) => e.value,
      );
    }

    final sentences = _splitSentences(result);
    if (sentences.length > 2) {
      final last = sentences.last.trim();
      if (last.length > 15) {
        result = '${sentences.take(math.min(2, sentences.length - 1)).join(' ')}\n\nKey point: $last';
      }
    }

    return result;
  }

  List<String> _splitSentences(String text) {
    return text
        .split(RegExp(r'(?<=[.!?।!?])\s+'))
        .where((s) => s.trim().isNotEmpty)
        .toList();
  }

  static const _resultWords = [
    'so ', 'hence', 'therefore', 'answer', 'means', 'thus', 'so the',
  ];

  static const _replacements = {
    'consequently': 'so',
    'subsequently': 'then',
    'approximately': 'about',
    'sufficient': 'enough',
    'demonstrate': 'show',
    'utilize': 'use',
    'implement': 'use',
    'establish': 'set',
    'determine': 'find',
    'obtain': 'get',
    'indicate': 'show',
    'possess': 'have',
    'requires': 'needs',
    'purchased': 'bought',
    'constructed': 'built',
    'additional': 'more',
    'significant': 'important',
  };
}
