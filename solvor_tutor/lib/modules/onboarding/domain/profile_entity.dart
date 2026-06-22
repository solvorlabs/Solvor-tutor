class ProfileEntity {
  final String id;
  final String? name;
  final String phoneNumber;
  final String selectedExam;
  final String uiLanguage;
  final int dailyCapacityMinutes;
  final List<String> weakDomains;

  const ProfileEntity({
    required this.id,
    this.name,
    required this.phoneNumber,
    required this.selectedExam,
    required this.uiLanguage,
    required this.dailyCapacityMinutes,
    required this.weakDomains,
  });
}
