import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/users_dao.dart';
import 'profile_entity.dart';

class OnboardingUseCase {
  final UsersDao _usersDao;

  OnboardingUseCase(this._usersDao);

  Future<void> saveProfile(ProfileEntity profile) async {
    final companion = UsersCompanion.insert(
      id: profile.id,
      name: Value(profile.name),
      phoneNumber: Value(profile.phoneNumber),
      selectedExam: Value(profile.selectedExam),
      uiLanguage: Value(profile.uiLanguage),
      dailyCapacityMinutes: Value(profile.dailyCapacityMinutes),
      weakDomains: jsonEncode(profile.weakDomains),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _usersDao.insertUser(companion);
  }

  Future<bool> hasProfile() async {
    final user = await _usersDao.getUser();
    return user != null;
  }
}
