import 'package:drift/drift.dart';

import '../app_database.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(super.db);

  Future<User?> getUser() async {
    final results = await select(users).get();
    if (results.isEmpty) return null;
    return results.first;
  }

  Future<void> insertUser(UsersCompanion user) async {
    await into(users).insert(user);
  }

  Future<void> deleteUser(String id) async {
    await (delete(users)..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateLanguage(String id, String language) async {
    await (update(users)..where((t) => t.id.equals(id)))
        .write(UsersCompanion(uiLanguage: Value(language)));
  }

  Future<void> updateDailyGoal(String id, int minutes) async {
    await (update(users)..where((t) => t.id.equals(id)))
        .write(UsersCompanion(dailyCapacityMinutes: Value(minutes)));
  }

  Future<void> updateProfile(String id, {String? name, String? email, String? exam, String? language, int? dailyGoal}) async {
    await (update(users)..where((t) => t.id.equals(id))).write(
      UsersCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        email: email != null ? Value(email) : const Value.absent(),
        selectedExam: exam != null ? Value(exam) : const Value.absent(),
        uiLanguage: language != null ? Value(language) : const Value.absent(),
        dailyCapacityMinutes: dailyGoal != null ? Value(dailyGoal) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
