import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/daos/users_dao.dart';
import '../domain/profile_entity.dart';

class OnboardingRepository {
  final UsersDao _usersDao;

  OnboardingRepository(this._usersDao);

  Future<void> saveProfile(ProfileEntity profile) async {
    final companion = UsersCompanion.insert(
      id: profile.id,
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
}
