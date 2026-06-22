import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/users_dao.dart';

import '../domain/onboarding_use_case.dart';
import '../domain/profile_entity.dart';

class OnboardingState {
  final int currentStep;
  final String? name;
  final String phoneNumber;
  final bool isOtpVerified;
  final String? selectedExam;
  final String? uiLanguage;
  final int? dailyCapacityMinutes;
  final List<String> weakDomains;
  final bool isSaving;
  final String? error;

  const OnboardingState({
    this.currentStep = 0,
    this.name,
    this.phoneNumber = '',
    this.isOtpVerified = false,
    this.selectedExam,
    this.uiLanguage,
    this.dailyCapacityMinutes,
    this.weakDomains = const [],
    this.isSaving = false,
    this.error,
  });

  OnboardingState copyWith({
    int? currentStep,
    String? name,
    String? phoneNumber,
    bool? isOtpVerified,
    String? selectedExam,
    String? uiLanguage,
    int? dailyCapacityMinutes,
    List<String>? weakDomains,
    bool? isSaving,
    String? error,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      selectedExam: selectedExam ?? this.selectedExam,
      uiLanguage: uiLanguage ?? this.uiLanguage,
      dailyCapacityMinutes: dailyCapacityMinutes ?? this.dailyCapacityMinutes,
      weakDomains: weakDomains ?? this.weakDomains,
      isSaving: isSaving ?? this.isSaving,
      error: error,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final OnboardingUseCase _useCase;

  OnboardingNotifier(this._useCase) : super(const OnboardingState());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setPhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void verifyOtp() {
    state = state.copyWith(isOtpVerified: true);
  }

  void skipOtp() {
    state = state.copyWith(isOtpVerified: true);
  }

  void setExam(String exam) {
    state = state.copyWith(selectedExam: exam);
  }

  void setLanguage(String language) {
    state = state.copyWith(uiLanguage: language);
  }

  void setBudget(int minutes) {
    state = state.copyWith(dailyCapacityMinutes: minutes);
  }

  void toggleWeakDomain(String domain) {
    final domains = List<String>.from(state.weakDomains);
    if (domains.contains(domain)) {
      domains.remove(domain);
    } else {
      domains.add(domain);
    }
    state = state.copyWith(weakDomains: domains);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<ProfileEntity?> completeOnboarding() async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      final profile = ProfileEntity(
        id: const Uuid().v4(),
        name: state.name,
        phoneNumber: state.phoneNumber,
        selectedExam: state.selectedExam ?? 'SSC',
        uiLanguage: state.uiLanguage ?? 'English',
        dailyCapacityMinutes: state.dailyCapacityMinutes ?? 60,
        weakDomains: List.from(state.weakDomains),
      );
      await _useCase.saveProfile(profile);
      state = state.copyWith(isSaving: false);
      return profile;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return null;
    }
  }

  void reset() {
    state = const OnboardingState();
  }
}

final usersDaoProvider = Provider<UsersDao>((ref) {
  final db = ref.watch(databaseProvider);
  return UsersDao(db);
});

final onboardingUseCaseProvider = Provider<OnboardingUseCase>((ref) {
  final dao = ref.watch(usersDaoProvider);
  return OnboardingUseCase(dao);
});

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final useCase = ref.watch(onboardingUseCaseProvider);
  return OnboardingNotifier(useCase);
});

final currentUserProvider = FutureProvider<User?>((ref) {
  final dao = ref.watch(usersDaoProvider);
  return dao.getUser();
});

enum AuthMethod { phone, google }

final authMethodProvider = StateProvider<AuthMethod?>((ref) => null);

final verificationIdProvider = StateProvider<String?>((ref) => null);
