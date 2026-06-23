import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class SearchResult {
  final String questionId;
  final String questionText;
  final String explanationText;
  final double relevanceScore;

  const SearchResult({
    required this.questionId,
    required this.questionText,
    required this.explanationText,
    required this.relevanceScore,
  });
}

class FTS5IndexBuilder {
  final AppDatabase _db;

  FTS5IndexBuilder(this._db);

  Future<void> buildIndex() async {
    try {
      await _db.customStatement(
        'CREATE VIRTUAL TABLE IF NOT EXISTS questions_fts USING fts5('
        'question_id UNINDEXED, question_en, question_hi, '
        'explanation_en, explanation_hi)',
      );

      final count = await _db
          .customSelect('SELECT COUNT(*) AS cnt FROM questions_fts')
          .get();
      if (count.first.data['cnt'] as int == 0) {
        await _db.customStatement(
          'INSERT INTO questions_fts(question_id, question_en, question_hi, '
          'explanation_en, explanation_hi) '
          'SELECT id, question_en, question_hi, explanation_en, explanation_hi '
          'FROM questions',
        );
      }
    } catch (_) {
      // FTS5 not available in SQLite build — search will fallback gracefully
    }
  }
}

class OfflineSearchEngine {
  final AppDatabase _db;
  bool _ftsAvailable = true;

  OfflineSearchEngine(this._db);

  Future<List<SearchResult>> search(String query,
      {String language = 'en'}) async {
    final sanitized = _sanitizeQuery(query);
    if (sanitized.isEmpty) return [];

    final langColumn = language == 'hi' ? 'question_hi' : 'question_en';
    final explColumn = language == 'hi' ? 'explanation_hi' : 'explanation_en';

    if (_ftsAvailable) {
      try {
        final rows = await _db.customSelect(
          'SELECT question_id, $langColumn AS question_text, '
          '$explColumn AS explanation_text, bm25(questions_fts) AS score '
          'FROM questions_fts '
          'WHERE questions_fts MATCH ?1 '
          'ORDER BY score '
          'LIMIT 5',
          variables: [Variable(sanitized)],
        ).get();

        return rows
            .map((row) => SearchResult(
                  questionId: row.data['question_id'] as String,
                  questionText: row.data['question_text'] as String,
                  explanationText: row.data['explanation_text'] as String,
                  relevanceScore: row.data['score'] as double,
                ))
            .toList();
      } catch (_) {
        _ftsAvailable = false;
        return await _fallbackSearch(query, language);
      }
    }

    return await _fallbackSearch(query, language);
  }

  Future<List<SearchResult>> _fallbackSearch(String query, String language) async {
    try {
      final langColumn = language == 'hi' ? 'question_hi' : 'question_en';
      final explColumn = language == 'hi' ? 'explanation_hi' : 'explanation_en';
      final like = '%${query.replaceAll("'", "''")}%';
      final rows = await _db.customSelect(
        'SELECT id AS question_id, $langColumn AS question_text, '
        '$explColumn AS explanation_text, 0.0 AS score '
        'FROM questions '
        'WHERE $langColumn LIKE ?1 '
        'LIMIT 5',
        variables: [Variable(like)],
      ).get();
      return rows
          .map((row) => SearchResult(
                questionId: row.data['question_id'] as String,
                questionText: row.data['question_text'] as String,
                explanationText: row.data['explanation_text'] as String,
                relevanceScore: row.data['score'] as double,
              ))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static const _stopWords = {
    'a', 'an', 'the', 'is', 'are', 'was', 'were', 'be', 'been', 'being',
    'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'could',
    'should', 'may', 'might', 'shall', 'can', 'what', 'which', 'who',
    'this', 'that', 'these', 'those', 'i', 'me', 'my', 'we', 'us', 'you',
    'he', 'she', 'it', 'its', 'they', 'of', 'in', 'on', 'at', 'to', 'for',
    'and', 'or', 'but', 'not', 'with', 'from', 'by', 'about', 'tell',
    'give', 'show', 'how', 'why', 'when', 'where',
  };

  List<String> getKeywords(String query) {
    final cleaned = query.replaceAll(RegExp(r'[^\w\s]'), ' ').trim();
    if (cleaned.isEmpty) return [];
    return cleaned
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty && !_stopWords.contains(w.toLowerCase()))
        .toList();
  }

  String _sanitizeQuery(String query) {
    final cleaned = query.replaceAll(RegExp(r'[^\w\s]'), ' ').trim();
    if (cleaned.isEmpty) return '';
    final words = cleaned
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty && !_stopWords.contains(w.toLowerCase()))
        .toList();
    if (words.isEmpty) return '';
    return words.map((w) => '$w*').join(' ');
  }
}
