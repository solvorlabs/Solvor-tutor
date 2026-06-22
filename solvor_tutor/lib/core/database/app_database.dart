import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'daos/attempts_dao.dart';
import 'daos/questions_dao.dart';
import 'daos/spaced_repetition_dao.dart';
import 'daos/sync_ledger_dao.dart';
import 'daos/tests_dao.dart';
import 'daos/users_dao.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get selectedExam => text().nullable()();
  TextColumn get uiLanguage => text().nullable()();
  IntColumn get dailyCapacityMinutes => integer().nullable()();
  TextColumn get weakDomains => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TaxonomyNodes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get parentId => text().nullable()();
  IntColumn get level => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Questions extends Table {
  TextColumn get id => text()();
  TextColumn get taxonomyId => text()();
  TextColumn get questionEn => text()();
  TextColumn get questionHi => text()();
  TextColumn get optionsEn => text()();
  TextColumn get optionsHi => text()();
  IntColumn get correctOption => integer()();
  TextColumn get difficultyLevel => text()();
  TextColumn get explanationEn => text()();
  TextColumn get explanationHi => text()();
  TextColumn get explanationHinglish => text()();
  TextColumn get shortcutFormulaNote => text().nullable()();
  TextColumn get commonMistakeNote => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Tests extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get testType => text()();
  IntColumn get totalQuestions => integer()();
  IntColumn get timeLimitMinutes => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TestQuestionMap extends Table {
  TextColumn get id => text()();
  TextColumn get testId => text()();
  TextColumn get questionId => text()();
  IntColumn get sequenceOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncLedger extends Table {
  TextColumn get id => text()();
  TextColumn get eventType => text()();
  TextColumn get payload => text()();
  DateTimeColumn get clientTimestamp => dateTime()();
  BoolColumn get processedStatus => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get testId => text()();
  TextColumn get questionId => text()();
  IntColumn get selectedOption => integer().nullable()();
  TextColumn get confidenceLevel => text().nullable()();
  BoolColumn get isCorrect => boolean().nullable()();
  IntColumn get timeTakenSeconds => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SpacedRepetition extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get questionId => text()();
  IntColumn get intervalDays => integer()();
  TextColumn get nextReviewDate => text()();
  BoolColumn get mastered => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Users,
    TaxonomyNodes,
    Questions,
    Tests,
    TestQuestionMap,
    SyncLedger,
    UserAttempts,
    SpacedRepetition,
  ],
  daos: [
    UsersDao,
    QuestionsDao,
    TestsDao,
    AttemptsDao,
    SpacedRepetitionDao,
    SyncLedgerDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(users, users.name);
            await m.addColumn(users, users.email);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA journal_mode=WAL;');
          await customStatement('PRAGMA foreign_keys=ON;');
        },
      );

  Future<bool> isSeedLoaded() async {
    final count = await (select(questions).map((q) => q.id).get());
    return count.isNotEmpty;
  }
}

LazyDatabase buildConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'solvor_tutor.db'));
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    return NativeDatabase(file);
  });
}

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(buildConnection());
});
