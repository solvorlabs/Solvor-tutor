import 'dart:convert';

import '../../../core/database/app_database.dart';

class TestSession {
  final String testId;
  final List<TestQuestionData> questions;
  int currentIndex;
  final Map<String, int> answers; // questionId → selectedOption
  final Map<String, String> confidence; // questionId → confidence level
  final Map<String, int> timeTaken; // questionId → seconds spent
  int elapsedSeconds;
  final DateTime startTime;
  bool isSubmitted;

  TestSession({
    required this.testId,
    required this.questions,
    this.currentIndex = 0,
    Map<String, int>? answers,
    Map<String, String>? confidence,
    Map<String, int>? timeTaken,
    this.elapsedSeconds = 0,
    DateTime? startTime,
    this.isSubmitted = false,
  })  : answers = answers ?? {},
        confidence = confidence ?? {},
        timeTaken = timeTaken ?? {},
        startTime = startTime ?? DateTime.now();

  TestQuestionData get currentQuestion => questions[currentIndex];
  int get totalQuestions => questions.length;
  int get answeredCount => answers.length;
  bool get allAnswered => answers.length >= totalQuestions;
  bool get isLastQuestion => currentIndex >= totalQuestions - 1;

  int? get currentAnswer => answers[currentQuestion.id];
  String? get currentConfidence => confidence[currentQuestion.id];
  int? get currentTimeTaken => timeTaken[currentQuestion.id];
}

class TestQuestionData {
  final String id;
  final String questionEn;
  final String questionHi;
  final List<String> optionsEn;
  final List<String> optionsHi;
  final int correctOption;
  final String difficultyLevel;
  final String explanationEn;
  final String explanationHi;
  final String explanationHinglish;
  final String? shortcutFormulaNote;
  final String? commonMistakeNote;
  final String subjectTag;

  TestQuestionData({
    required this.id,
    required this.questionEn,
    required this.questionHi,
    required this.optionsEn,
    required this.optionsHi,
    required this.correctOption,
    required this.difficultyLevel,
    required this.explanationEn,
    required this.explanationHi,
    required this.explanationHinglish,
    this.shortcutFormulaNote,
    this.commonMistakeNote,
    required this.subjectTag,
  });

  factory TestQuestionData.fromQuestion(
    Question q, {
    required String subjectTag,
    String? shortcutFormulaNote,
    String? commonMistakeNote,
  }) {
    return TestQuestionData(
      id: q.id,
      questionEn: q.questionEn,
      questionHi: q.questionHi,
      optionsEn: List<String>.from(jsonDecode(q.optionsEn) as List),
      optionsHi: List<String>.from(jsonDecode(q.optionsHi) as List),
      correctOption: q.correctOption,
      difficultyLevel: q.difficultyLevel,
      explanationEn: q.explanationEn,
      explanationHi: q.explanationHi,
      explanationHinglish: q.explanationHinglish,
      shortcutFormulaNote: q.shortcutFormulaNote ?? shortcutFormulaNote,
      commonMistakeNote: q.commonMistakeNote ?? commonMistakeNote,
      subjectTag: subjectTag,
    );
  }
}
