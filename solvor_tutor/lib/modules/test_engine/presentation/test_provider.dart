import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/attempts_dao.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../../../core/database/daos/tests_dao.dart';
import '../../../core/database/daos/users_dao.dart';
import '../data/test_session_model.dart';
import '../domain/test_session_use_case.dart';

class TestState {
  final TestSession? session;
  final bool isLoading;
  final bool isSubmitting;
  final int timeInSeconds;
  final String? error;

  const TestState({
    this.session,
    this.isLoading = true,
    this.isSubmitting = false,
    this.timeInSeconds = 0,
    this.error,
  });

  TestState copyWith({
    TestSession? session,
    bool? isLoading,
    bool? isSubmitting,
    int? timeInSeconds,
    String? error,
  }) {
    return TestState(
      session: session ?? this.session,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      timeInSeconds: timeInSeconds ?? this.timeInSeconds,
      error: error,
    );
  }
}

class TestNotifier extends StateNotifier<TestState> {
  final TestSessionUseCase _useCase;
  final UsersDao _usersDao;
  Timer? _timer;
  int _lastPersistTime = 0;
  String? _userId;

  TestNotifier(this._useCase, this._usersDao) : super(const TestState());

  Future<void> loadTest(String testId) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _usersDao.getUser();
      _userId = user?.id;
      final session = await _useCase.loadTest(testId);
      state = state.copyWith(
        session: session,
        isLoading: false,
        timeInSeconds: session.elapsedSeconds,
      );
      _startTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newTime = state.timeInSeconds + 1;
      state = state.copyWith(timeInSeconds: newTime);

      if (newTime - _lastPersistTime >= 5 || newTime % 5 == 0) {
        _lastPersistTime = newTime;
        if (state.session != null) {
          _useCase.saveTimerState(state.session!.testId, newTime);
        }
      }
    });
  }

  void selectAnswer(int optionIndex) {
    if (state.session == null) return;
    final session = state.session!;
    session.answers[session.currentQuestion.id] = optionIndex;
    state = state.copyWith(session: session);
  }

  void setConfidence(String level) {
    if (state.session == null) return;
    final session = state.session!;
    session.confidence[session.currentQuestion.id] = level;
    state = state.copyWith(session: session);
  }

  void goToNextQuestion() {
    if (state.session == null) return;
    final session = state.session!;
    if (session.currentIndex < session.totalQuestions - 1) {
      session.currentIndex++;
      state = state.copyWith(session: session);
    }
  }

  void goToPreviousQuestion() {
    if (state.session == null) return;
    final session = state.session!;
    if (session.currentIndex > 0) {
      session.currentIndex--;
      state = state.copyWith(session: session);
    }
  }

  void goToQuestion(int index) {
    if (state.session == null) return;
    final session = state.session!;
    if (index >= 0 && index < session.totalQuestions) {
      session.currentIndex = index;
      state = state.copyWith(session: session);
    }
  }

  Future<String?> submitCurrentAnswer() async {
    if (state.session == null || _userId == null) return null;
    final session = state.session!;
    final q = session.currentQuestion;
    final answer = session.answers[q.id];
    final conf = session.confidence[q.id];
    if (answer == null || conf == null) return null;

    final timeSpent = session.timeTaken[q.id] ?? 30;

    await _useCase.submitAnswer(
      testId: session.testId,
      questionId: q.id,
      selectedOption: answer,
      confidenceLevel: conf,
      timeTakenSeconds: timeSpent,
      userId: _userId!,
      isCorrect: answer == q.correctOption,
    );
    return q.id;
  }

  Future<String> submitTest() async {
    if (state.session == null) return '';
    final session = state.session!;
    state = state.copyWith(isSubmitting: true);
    await _useCase.submitTest(session.testId);
    _timer?.cancel();
    state = state.copyWith(isSubmitting: false);
    return session.testId;
  }

  void onAppLifecycleChange(AppLifecycleState lifecycle) {
    if (lifecycle == AppLifecycleState.paused && state.session != null) {
      _useCase.saveTimerState(state.session!.testId, state.timeInSeconds);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final testSessionUseCaseProvider = Provider<TestSessionUseCase>((ref) {
  final db = ref.watch(databaseProvider);
  return TestSessionUseCase(
    TestsDao(db),
    QuestionsDao(db),
    AttemptsDao(db),
  );
});

final testProvider =
    StateNotifierProvider.autoDispose.family<TestNotifier, TestState, String>(
  (ref, testId) {
    final useCase = ref.watch(testSessionUseCaseProvider);
    final usersDao = UsersDao(ref.watch(databaseProvider));
    final notifier = TestNotifier(useCase, usersDao);
    notifier.loadTest(testId);
    ref.onDispose(() => notifier.dispose());
    return notifier;
  },
);
