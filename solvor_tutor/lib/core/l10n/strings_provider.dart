import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/onboarding/presentation/onboarding_provider.dart';

final langProvider = Provider<String?>((ref) {
  return ref.watch(currentUserProvider).asData?.value?.uiLanguage;
});
