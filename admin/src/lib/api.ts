const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';

function getToken(): string | null {
  if (typeof window === 'undefined') return null;
  return localStorage.getItem('admin_token');
}

async function request<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = getToken();
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    ...((options.headers as Record<string, string>) || {}),
  };
  if (token) headers['Authorization'] = `Bearer ${token}`;

  const res = await fetch(`${API_URL}${path}`, { ...options, headers });

  if (res.status === 401) {
    localStorage.removeItem('admin_token');
    if (typeof window !== 'undefined') window.location.href = '/login';
    throw new Error('Unauthorized');
  }

  const data = await res.json();
  if (!res.ok) throw new Error(data.error || 'Request failed');
  return data;
}

export interface Question {
  id: string; taxonomyId: string; questionEn: string; questionHi: string;
  optionsEn: string[]; optionsHi: string[]; correctOption: number;
  difficultyLevel: string; explanationEn: string; explanationHi: string;
  explanationHinglish: string; shortcutFormulaNote?: string; commonMistakeNote?: string;
  createdAt: string;
}

export interface TaxonomyNode {
  id: string; name: string; parentId: string | null; level: number; children: TaxonomyNode[];
}

export const api = {
  questions: {
    list: (params?: string) =>
      request<{ questions: Question[]; pagination: { page: number; limit: number; total: number } }>(
        `/questions${params ? `?${params}` : ''}`
      ),
    get: (id: string) => request<Question>(`/questions/${id}`),
    create: (data: Record<string, unknown>) =>
      request<Question>('/questions', { method: 'POST', body: JSON.stringify(data) }),
    update: (id: string, data: Record<string, unknown>) =>
      request<Question>(`/questions/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  },
  taxonomy: {
    list: () => request<TaxonomyNode[]>('/taxonomy'),
    create: (data: Record<string, unknown>) =>
      request<TaxonomyNode>('/taxonomy', { method: 'POST', body: JSON.stringify(data) }),
    update: (id: string, data: Record<string, unknown>) =>
      request<TaxonomyNode>(`/taxonomy/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  },
  admin: {
    importQuestions: (questions: Record<string, unknown>[]) =>
      request<{ inserted: number; failed: number; errors: { row: number; message: string }[] }>(
        '/admin/import', { method: 'POST', body: JSON.stringify({ questions }) }
      ),
  },
  analytics: {
    get: () =>
      request<{ rows: Record<string, unknown>[] }>('/admin/analytics'),
  },
};
