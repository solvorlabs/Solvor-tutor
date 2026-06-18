import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/attempts_dao.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../data/review_repository.dart';

final reviewDataProvider =
    FutureProvider.autoDispose.family<ReviewData, String>((ref, testId) {
  final db = ref.watch(databaseProvider);
  final repo = ReviewRepository(QuestionsDao(db), AttemptsDao(db));
  return repo.getReviewData(testId);
});
