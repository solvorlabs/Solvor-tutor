import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../onboarding/presentation/onboarding_provider.dart';

class StreakData {
  final int currentStreak;
  final bool studiedToday;
  final DateTime? lastStudyDate;

  const StreakData({
    required this.currentStreak,
    required this.studiedToday,
    this.lastStudyDate,
  });
}

class DailyProgress {
  final int questionsAnswered;
  final int dailyGoal;

  const DailyProgress({required this.questionsAnswered, required this.dailyGoal});

  double get fraction =>
      dailyGoal == 0 ? 0 : (questionsAnswered / dailyGoal).clamp(0.0, 1.0);
  bool get isComplete => questionsAnswered >= dailyGoal;
}

final _prefsProvider = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);

final streakProvider = FutureProvider<StreakData>((ref) async {
  final prefs = await ref.watch(_prefsProvider.future);
  final lastStr = prefs.getString('last_study_date');
  final streak = prefs.getInt('streak') ?? 0;

  if (lastStr == null) {
    return const StreakData(currentStreak: 0, studiedToday: false);
  }

  final last = DateTime.parse(lastStr);
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final lastDate = DateTime(last.year, last.month, last.day);
  final diff = todayDate.difference(lastDate).inDays;

  if (diff == 0) {
    return StreakData(currentStreak: streak, studiedToday: true, lastStudyDate: last);
  } else if (diff == 1) {
    return StreakData(currentStreak: streak, studiedToday: false, lastStudyDate: last);
  } else {
    return StreakData(currentStreak: 0, studiedToday: false, lastStudyDate: last);
  }
});

final dailyProgressProvider = FutureProvider<DailyProgress>((ref) async {
  final prefs = await ref.watch(_prefsProvider.future);
  final userAsync = await ref.watch(currentUserProvider.future);

  final today = DateTime.now();
  final key = 'daily_q_${today.year}_${today.month}_${today.day}';
  final answered = prefs.getInt(key) ?? 0;
  final mins = userAsync?.dailyCapacityMinutes ?? 30;
  final goal = (mins * 2).clamp(5, 60);

  return DailyProgress(questionsAnswered: answered, dailyGoal: goal);
});

final homeGreetingProvider = FutureProvider<String>((ref) async {
  final userAsync = await ref.watch(currentUserProvider.future);
  final streakData = await ref.watch(streakProvider.future);

  final name = userAsync?.name ?? '';
  final firstName = name.split(' ').first;
  final weakDomainsRaw = userAsync?.weakDomains ?? '[]';
  List<String> weakList = [];
  try {
    weakList = List<String>.from(jsonDecode(weakDomainsRaw) as List);
  } catch (_) {}
  final topic = weakList.isNotEmpty ? weakList.first : 'General Studies';

  final hour = DateTime.now().hour;
  final greeting = hour < 12 ? 'Suprabhat' : (hour < 17 ? 'Namaste' : 'Shubh Sandhya');

  if (streakData.studiedToday) {
    return '$greeting $firstName! Aaj ${streakData.currentStreak} din ho gaye 🔥 Chalte rahein!';
  } else if (streakData.currentStreak > 0) {
    return '$greeting $firstName! ${streakData.currentStreak} din ki streak — aaj $topic practice karein?';
  } else {
    return '$greeting $firstName! Aaj $topic se shuruat karein?';
  }
});

Future<void> markStudiedToday(SharedPreferences prefs) async {
  final today = DateTime.now();
  final todayStr = today.toIso8601String();
  final lastStr = prefs.getString('last_study_date');
  int streak = prefs.getInt('streak') ?? 0;

  if (lastStr != null) {
    final last = DateTime.parse(lastStr);
    final lastDate = DateTime(last.year, last.month, last.day);
    final todayDate = DateTime(today.year, today.month, today.day);
    final diff = todayDate.difference(lastDate).inDays;
    if (diff == 1) streak += 1;
    else if (diff == 0) {}
    else streak = 1;
  } else {
    streak = 1;
  }

  await prefs.setString('last_study_date', todayStr);
  await prefs.setInt('streak', streak);
}

Future<void> incrementDailyQuestions(SharedPreferences prefs) async {
  final today = DateTime.now();
  final key = 'daily_q_${today.year}_${today.month}_${today.day}';
  final current = prefs.getInt(key) ?? 0;
  await prefs.setInt(key, current + 1);
}
