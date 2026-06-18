import '../../../core/database/daos/attempts_dao.dart';
import '../../../core/database/daos/questions_dao.dart';
import '../data/review_repository.dart';

class ReviewUseCase {
  final QuestionsDao _questionsDao;
  final AttemptsDao _attemptsDao;

  ReviewUseCase(this._questionsDao, this._attemptsDao);

  Future<ReviewData> getReviewData(String testId) async {
    final repo = ReviewRepository(_questionsDao, _attemptsDao);
    return repo.getReviewData(testId);
  }
}
