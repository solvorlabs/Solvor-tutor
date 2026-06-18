import 'package:drift/drift.dart';

import '../app_database.dart';

part 'attempts_dao.g.dart';

@DriftAccessor(tables: [UserAttempts])
class AttemptsDao extends DatabaseAccessor<AppDatabase>
    with _$AttemptsDaoMixin {
  AttemptsDao(super.db);

  Future<void> insertAttempt(UserAttemptsCompanion attempt) async {
    await into(userAttempts).insert(attempt);
  }

  Future<List<UserAttempt>> getAttemptsForTest(String testId) async {
    return (select(userAttempts)
          ..where((t) => t.testId.equals(testId))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();
  }

  Future<List<UserAttempt>> getAttemptsForUser(String userId) async {
    return (select(userAttempts)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();
  }

  Future<List<UserAttempt>> getAttemptsForQuestion(String questionId) async {
    return (select(userAttempts)
          ..where((t) => t.questionId.equals(questionId)))
        .get();
  }

  Future<void> updateAttempt(
    String id,
    UserAttemptsCompanion updates,
  ) async {
    await (update(userAttempts)..where((t) => t.id.equals(id))).write(updates);
  }

  Future<double> getAccuracyForUser(String userId) async {
    final rows = await (select(userAttempts)
          ..where((t) => t.userId.equals(userId)))
        .get();
    if (rows.isEmpty) return 0.0;
    final correct = rows.where((a) => a.isCorrect == true).length;
    return correct / rows.length;
  }
}
