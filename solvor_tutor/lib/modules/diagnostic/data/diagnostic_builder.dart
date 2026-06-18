import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../../../core/database/daos/tests_dao.dart';

class DiagnosticTestBuilder {
  final TestsDao _testsDao;
  final QuestionsDao _questionsDao;

  DiagnosticTestBuilder(this._testsDao, this._questionsDao);

  static const _subjectIds = [
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890', // Quantitative Aptitude
    'b2c3d4e5-f6a7-8901-bcde-f12345678901', // Logical Reasoning
    'c3d4e5f6-a7b8-9012-cdef-123456789012', // English Language
    'd1e2f3a4-b5c6-7890-defa-012345678901', // General Knowledge
  ];

  static const int questionsPerSubject = 5;
  static const int totalQuestions = 20;
  static const int timeLimitMinutes = 20;

  Future<String> buildDiagnosticTest(String userId) async {
    final testId = const Uuid().v4();
    final allQuestions = <Question>[];

    for (final subjectId in _subjectIds) {
      final questions = await _questionsDao.getRandomQuestionsBySubject(
        subjectId,
        questionsPerSubject,
      );
      allQuestions.addAll(questions);
    }

    allQuestions.shuffle();

    final uuid = const Uuid();
    final testCompanion = TestsCompanion.insert(
      id: testId,
      userId: userId,
      testType: 'DIAGNOSTIC',
      totalQuestions: allQuestions.length,
      timeLimitMinutes: timeLimitMinutes,
      startedAt: DateTime.now(),
    );

    final mappings = <TestQuestionMapCompanion>[];
    for (int i = 0; i < allQuestions.length; i++) {
      mappings.add(TestQuestionMapCompanion.insert(
        id: uuid.v4(),
        testId: testId,
        questionId: allQuestions[i].id,
        sequenceOrder: i,
      ));
    }

    await _testsDao.insertTest(testCompanion);
    await _testsDao.insertTestQuestionMap(mappings);

    return testId;
  }
}
