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
}
