import 'package:drift/drift.dart';

import '../app_database.dart';

part 'tests_dao.g.dart';

@DriftAccessor(tables: [Tests, TestQuestionMap])
class TestsDao extends DatabaseAccessor<AppDatabase> with _$TestsDaoMixin {
  TestsDao(super.db);

  Future<void> insertTest(TestsCompanion test) async {
    await into(tests).insert(test);
  }

  Future<Test?> getTestById(String id) async {
    final results = await (select(tests)..where((t) => t.id.equals(id))).get();
    return results.isEmpty ? null : results.first;
  }

  Future<List<Test>> getTestsByUser(String userId) async {
    return (select(tests)..where((t) => t.userId.equals(userId))).get();
  }

  Future<void> updateTestCompletedAt(String id, DateTime completedAt) async {
    await (update(tests)..where((t) => t.id.equals(id))).write(
      TestsCompanion(completedAt: Value(completedAt)),
    );
  }

  Future<void> insertTestQuestionMap(
    List<TestQuestionMapCompanion> mappings,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(testQuestionMap, mappings);
    });
  }

  Future<List<TestQuestionMapData>> getQuestionsForTest(String testId) async {
    return (select(testQuestionMap)
          ..where((t) => t.testId.equals(testId))
          ..orderBy([(t) => OrderingTerm(expression: t.sequenceOrder)]))
        .get();
  }

  Future<int> countTestsByType(String testType) async {
    final results = await (select(tests)
          ..where((t) => t.testType.equals(testType)))
        .get();
    return results.length;
  }
}
