import 'dart:convert';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/attempts_dao.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../../test_engine/data/test_session_model.dart';

class ReviewRepository {
  final QuestionsDao _questionsDao;
  final AttemptsDao _attemptsDao;

  ReviewRepository(this._questionsDao, this._attemptsDao);

  Future<ReviewData> getReviewData(String testId) async {
    final attempts = await _attemptsDao.getAttemptsForTest(testId);
    final questions = <Question>[];
    final questionAttempts = <String, UserAttempt>{};

    for (final a in attempts) {
      final q = await _questionsDao.getQuestionById(a.questionId);
      if (q != null) {
        questions.add(q);
        questionAttempts[q.id] = a;
      }
    }

    return ReviewData(
      totalQuestions: questions.length,
      correctCount:
          attempts.where((a) => a.isCorrect == true).length,
      totalTimeSeconds:
          attempts.fold<int>(0, (sum, a) => sum + (a.timeTakenSeconds ?? 0)),
      questions: questions,
      attempts: questionAttempts,
    );
  }
}

class ReviewData {
  final int totalQuestions;
  final int correctCount;
  final int totalTimeSeconds;
  final List<Question> questions;
  final Map<String, UserAttempt> attempts;

  const ReviewData({
    required this.totalQuestions,
    required this.correctCount,
    required this.totalTimeSeconds,
    required this.questions,
    required this.attempts,
  });

  double get accuracy => totalQuestions > 0 ? correctCount / totalQuestions : 0;
  double get avgTimePerQuestion =>
      totalQuestions > 0 ? totalTimeSeconds / totalQuestions : 0;
  int get wrongCount => totalQuestions - correctCount;

  Map<String, int> get speedAccuracyQuadrants {
    if (questions.isEmpty) return {};

    final times = questions
        .map((q) => attempts[q.id]?.timeTakenSeconds ?? 0)
        .where((t) => t > 0)
        .toList();
    if (times.isEmpty) return {};

    times.sort();
    final median = times[times.length ~/ 2];

    int fastCorrect = 0, slowCorrect = 0, fastWrong = 0, slowWrong = 0;

    for (final q in questions) {
      final time = attempts[q.id]?.timeTakenSeconds ?? 0;
      final isCorrect = attempts[q.id]?.isCorrect == true;
      final isFast = time <= median;

      if (isFast && isCorrect) fastCorrect++;
      else if (!isFast && isCorrect) slowCorrect++;
      else if (isFast && !isCorrect) fastWrong++;
      else slowWrong++;
    }

    return {
      'Fast+Correct': fastCorrect,
      'Slow+Correct': slowCorrect,
      'Fast+Wrong': fastWrong,
      'Slow+Wrong': slowWrong,
    };
  }
}
