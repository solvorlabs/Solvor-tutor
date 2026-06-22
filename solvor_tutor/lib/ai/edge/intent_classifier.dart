import 'package:tflite_flutter/tflite_flutter.dart';

enum IntentType { conceptDoubt, formulaLookup, translationRequest, unknown }

class IntentClassifier {
  Interpreter? _interpreter;

  Future<void> load() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('models/intent_classifier.tflite');
    } catch (_) {
      _interpreter = null;
    }
  }

  Future<IntentType> classifyIntent(String query) async {
    if (_interpreter != null) {
      try {
        // Real model inference goes here when model is dropped in
        return IntentType.unknown;
      } catch (_) {}
    }
    // Keyword-based fallback — works without TFLite model
    return _keywordClassify(query);
  }

  IntentType _keywordClassify(String query) {
    final q = query.toLowerCase();

    const formulaKeywords = [
      'formula', 'shortcut', 'trick', 'calculate', 'how to solve',
      'theorem', 'rule', 'method', 'equation', 'calculate',
      'percentage', 'profit', 'loss', 'time', 'work', 'speed',
      'distance', 'ratio', 'average', 'interest',
    ];
    const translationKeywords = [
      'hindi', 'english', 'translate', 'meaning', 'matlab',
      'ka arth', 'kya hota', 'in hindi', 'in english',
      'hinglish', 'language',
    ];
    const conceptKeywords = [
      'what is', 'what are', 'explain', 'define', 'definition',
      'concept', 'kya hai', 'why', 'how does', 'difference between',
      'types of', 'example of', 'understand',
    ];

    if (formulaKeywords.any((k) => q.contains(k))) {
      return IntentType.formulaLookup;
    }
    if (translationKeywords.any((k) => q.contains(k))) {
      return IntentType.translationRequest;
    }
    if (conceptKeywords.any((k) => q.contains(k))) {
      return IntentType.conceptDoubt;
    }
    return IntentType.unknown;
  }
}
