class ProfileEntity {
  final String id;
  final String phoneNumber;
  final String selectedExam;
  final String uiLanguage;
  final int dailyCapacityMinutes;
  final List<String> weakDomains;

  const ProfileEntity({
    required this.id,
    required this.phoneNumber,
    required this.selectedExam,
    required this.uiLanguage,
    required this.dailyCapacityMinutes,
    required this.weakDomains,
  });
}
