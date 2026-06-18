export interface Question {
  id: string;
  taxonomyId: string;
  questionEn: string;
  questionHi: string;
  optionsEn: string[];
  optionsHi: string[];
  correctOption: number;
  difficultyLevel: string;
  explanationEn: string;
  explanationHi: string;
  explanationHinglish: string;
  shortcutFormulaNote?: string;
  commonMistakeNote?: string;
  createdAt: string;
}

export interface QuestionFormData {
  taxonomyId: string;
  questionEn: string;
  questionHi: string;
  optionsEn: string[];
  optionsHi: string[];
  correctOption: number;
  difficultyLevel: string;
  explanationEn: string;
  explanationHi: string;
  explanationHinglish: string;
  shortcutFormulaNote?: string;
  commonMistakeNote?: string;
}

export interface TaxonomyNode {
  id: string;
  name: string;
  parentId: string | null;
  level: number;
  children: TaxonomyNode[];
}

export interface PaginatedResponse<T> {
  questions: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
}

export interface ImportResult {
  inserted: number;
  failed: number;
  errors: { row: number; message: string }[];
}

export interface AnalyticsRow {
  questionId: string;
  questionText: string;
  totalAttempts: number;
  correctAttempts: number;
  accuracyRate: number;
  avgTimeSeconds: number;
  difficultyLevel: string;
  topicName: string;
}
