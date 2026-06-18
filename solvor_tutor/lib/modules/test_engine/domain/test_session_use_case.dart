import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/attempts_dao.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../../../core/database/daos/tests_dao.dart';
import '../data/test_session_model.dart';

class TestSessionUseCase {
  final TestsDao _testsDao;
  final QuestionsDao _questionsDao;
  final AttemptsDao _attemptsDao;

  TestSessionUseCase(this._testsDao, this._questionsDao, this._attemptsDao);

  Future<TestSession> loadTest(String testId) async {
    final test = await _testsDao.getTestById(testId);
    if (test == null) throw Exception('Test not found: $testId');

    final mappings = await _testsDao.getQuestionsForTest(testId);
    final questions = <TestQuestionData>[];

    for (final mapping in mappings) {
      final q = await _questionsDao.getQuestionById(mapping.questionId);
      if (q == null) continue;

      final subject = await _getSubjectTag(q.taxonomyId);
      questions.add(TestQuestionData.fromQuestion(q, subjectTag: subject));
    }

    final elapsed = await _loadTimer(testId);
    final existingAttempts = await _attemptsDao.getAttemptsForTest(testId);
    final answers = <String, int>{};
    final confidence = <String, String>{};
    final timeTaken = <String, int>{};
    for (final a in existingAttempts) {
      if (a.selectedOption != null) answers[a.questionId] = a.selectedOption!;
      if (a.confidenceLevel != null) confidence[a.questionId] = a.confidenceLevel!;
      if (a.timeTakenSeconds != null) timeTaken[a.questionId] = a.timeTakenSeconds!;
    }

    int currentIndex = 0;
    for (int i = 0; i < questions.length; i++) {
      if (!answers.containsKey(questions[i].id)) {
        currentIndex = i;
        break;
      }
      currentIndex = i + 1;
    }
    if (currentIndex >= questions.length) {
      currentIndex = questions.length - 1;
    }

    return TestSession(
      testId: testId,
      questions: questions,
      currentIndex: currentIndex,
      answers: answers,
      confidence: confidence,
      timeTaken: timeTaken,
      elapsedSeconds: elapsed,
      startTime: test.startedAt,
    );
  }

  Future<void> submitAnswer({
    required String testId,
    required String questionId,
    required int selectedOption,
    required String confidenceLevel,
    required int timeTakenSeconds,
    required String userId,
    required bool isCorrect,
  }) async {
    await _attemptsDao.insertAttempt(UserAttemptsCompanion(
      id: Value(const Uuid().v4()),
      userId: Value(userId),
      testId: Value(testId),
      questionId: Value(questionId),
      selectedOption: Value(selectedOption),
      confidenceLevel: Value(confidenceLevel),
      isCorrect: Value(isCorrect),
      timeTakenSeconds: Value(timeTakenSeconds),
      createdAt: Value(DateTime.now()),
    ));
  }

  Future<void> submitTest(String testId) async {
    await _testsDao.updateTestCompletedAt(testId, DateTime.now());
    await _saveTimer(testId, 0);
  }

  Future<void> saveTimerState(String testId, int elapsedSeconds) async {
    await _saveTimer(testId, elapsedSeconds);
  }

  Future<int> _loadTimer(String testId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('test_timer_$testId') ?? 0;
  }

  Future<void> _saveTimer(String testId, int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('test_timer_$testId', seconds);
  }

  Future<String> _getSubjectTag(String taxonomyId) async {
    final node = await _questionsDao.getTaxonomyNode(taxonomyId);
    if (node == null) return 'General';
    if (node.level == 0) return node.name;
    final parent = node.parentId != null
        ? await _questionsDao.getTaxonomyNode(node.parentId!)
        : null;
    if (parent != null && parent.level == 0) return parent.name;
    final grandparent = parent?.parentId != null
        ? await _questionsDao.getTaxonomyNode(parent!.parentId!)
        : null;
    if (grandparent != null && grandparent.level == 0) return grandparent.name;
    return node.name;
  }
}
