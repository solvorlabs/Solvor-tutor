import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/daos/users_dao.dart';
import '../database/app_database.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;

  const AuthState({this.isLoggedIn = false, this.isLoading = true});

  AuthState copyWith({bool? isLoggedIn, bool? isLoading}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final UsersDao _dao;

  AuthStateNotifier(this._dao) : super(const AuthState()) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final user = await _dao.getUser();
    state = AuthState(isLoggedIn: user != null, isLoading: false);
  }

  void setLoggedIn(bool value) {
    state = state.copyWith(isLoggedIn: value, isLoading: false);
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) {
    final db = ref.watch(databaseProvider);
    final dao = UsersDao(db);
    return AuthStateNotifier(dao);
  },
);
