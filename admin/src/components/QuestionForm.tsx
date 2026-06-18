'use client';

import { useState, useEffect, FormEvent } from 'react';
import { api, TaxonomyNode } from '@/lib/api';

interface Props {
  initialData?: Record<string, unknown>;
  onSubmit: (data: Record<string, unknown>) => Promise<void>;
  submitLabel: string;
}

export default function QuestionForm({ initialData, onSubmit, submitLabel }: Props) {
  const [taxonomyNodes, setTaxonomyNodes] = useState<TaxonomyNode[]>([]);
  const [loading, setLoading] = useState(false);

  const [form, setForm] = useState({
    taxonomyId: (initialData?.taxonomyId as string) || '',
    questionEn: (initialData?.questionEn as string) || '',
    questionHi: (initialData?.questionHi as string) || '',
    optionsEn: (initialData?.optionsEn as string[]) || ['', '', '', ''],
    optionsHi: (initialData?.optionsHi as string[]) || ['', '', '', ''],
    correctOption: (initialData?.correctOption as number) ?? 0,
    difficultyLevel: (initialData?.difficultyLevel as string) || 'medium',
    explanationEn: (initialData?.explanationEn as string) || '',
    explanationHi: (initialData?.explanationHi as string) || '',
    explanationHinglish: (initialData?.explanationHinglish as string) || '',
    shortcutFormulaNote: (initialData?.shortcutFormulaNote as string) || '',
    commonMistakeNote: (initialData?.commonMistakeNote as string) || '',
  });

  useEffect(() => {
    api.taxonomy.list().then(setTaxonomyNodes).catch(console.error);
  }, []);

  function flattenNodes(nodes: TaxonomyNode[], depth = 0): { id: string; name: string; depth: number }[] {
    const result: { id: string; name: string; depth: number }[] = [];
    for (const n of nodes) {
      result.push({ id: n.id, name: n.name, depth });
      if (n.children) result.push(...flattenNodes(n.children, depth + 1));
    }
    return result;
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setLoading(true);
    try {
      await onSubmit({
        ...form,
        shortcutFormulaNote: form.shortcutFormulaNote || undefined,
        commonMistakeNote: form.commonMistakeNote || undefined,
      });
    } finally {
      setLoading(false);
    }
  }

  const flatTaxonomy = flattenNodes(taxonomyNodes);

  return (
    <form onSubmit={handleSubmit} className="space-y-4 max-w-3xl">
      <div>
        <label className="block text-sm font-medium mb-1">Taxonomy</label>
        <select
          className="w-full border rounded px-3 py-2 text-sm"
          value={form.taxonomyId}
          onChange={(e) => setForm({ ...form, taxonomyId: e.target.value })}
          required
        >
          <option value="">Select topic...</option>
          {flatTaxonomy.map((n) => (
            <option key={n.id} value={n.id}>
              {'  '.repeat(n.depth)}{n.name}
            </option>
          ))}
        </select>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium mb-1">Question (EN)</label>
          <textarea
            className="w-full border rounded px-3 py-2 text-sm"
            rows={3}
            value={form.questionEn}
            onChange={(e) => setForm({ ...form, questionEn: e.target.value })}
            required
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-1">Question (HI)</label>
          <textarea
            className="w-full border rounded px-3 py-2 text-sm"
            rows={3}
            value={form.questionHi}
            onChange={(e) => setForm({ ...form, questionHi: e.target.value })}
            required
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium mb-1">Options (EN)</label>
          {form.optionsEn.map((opt, i) => (
            <input
              key={i}
              type="text"
              className="w-full border rounded px-3 py-2 text-sm mb-1"
              placeholder={`Option ${i + 1}`}
              value={opt}
              onChange={(e) => {
                const opts = [...form.optionsEn];
                opts[i] = e.target.value;
                setForm({ ...form, optionsEn: opts });
              }}
              required
            />
          ))}
        </div>
        <div>
          <label className="block text-sm font-medium mb-1">Options (HI)</label>
          {form.optionsHi.map((opt, i) => (
            <input
              key={i}
              type="text"
              className="w-full border rounded px-3 py-2 text-sm mb-1"
              placeholder={`Option ${i + 1}`}
              value={opt}
              onChange={(e) => {
                const opts = [...form.optionsHi];
                opts[i] = e.target.value;
                setForm({ ...form, optionsHi: opts });
              }}
              required
            />
          ))}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium mb-1">Correct Option (0-3)</label>
          <input
            type="number"
            min={0}
            max={3}
            className="w-full border rounded px-3 py-2 text-sm"
            value={form.correctOption}
            onChange={(e) => setForm({ ...form, correctOption: parseInt(e.target.value) || 0 })}
            required
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-1">Difficulty</label>
          <select
            className="w-full border rounded px-3 py-2 text-sm"
            value={form.difficultyLevel}
            onChange={(e) => setForm({ ...form, difficultyLevel: e.target.value })}
          >
            <option value="easy">Easy</option>
            <option value="medium">Medium</option>
            <option value="hard">Hard</option>
          </select>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium mb-1">Explanation (EN)</label>
          <textarea
            className="w-full border rounded px-3 py-2 text-sm"
            rows={3}
            value={form.explanationEn}
            onChange={(e) => setForm({ ...form, explanationEn: e.target.value })}
            required
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-1">Explanation (HI)</label>
          <textarea
            className="w-full border rounded px-3 py-2 text-sm"
            rows={3}
            value={form.explanationHi}
            onChange={(e) => setForm({ ...form, explanationHi: e.target.value })}
            required
          />
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium mb-1">Explanation (Hinglish)</label>
        <textarea
          className="w-full border rounded px-3 py-2 text-sm"
          rows={2}
          value={form.explanationHinglish}
          onChange={(e) => setForm({ ...form, explanationHinglish: e.target.value })}
        />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium mb-1">Shortcut Formula Note</label>
          <textarea
            className="w-full border rounded px-3 py-2 text-sm"
            rows={2}
            value={form.shortcutFormulaNote}
            onChange={(e) => setForm({ ...form, shortcutFormulaNote: e.target.value })}
          />
        </div>
        <div>
          <label className="block text-sm font-medium mb-1">Common Mistake Note</label>
          <textarea
            className="w-full border rounded px-3 py-2 text-sm"
            rows={2}
            value={form.commonMistakeNote}
            onChange={(e) => setForm({ ...form, commonMistakeNote: e.target.value })}
          />
        </div>
      </div>

      <button
        type="submit"
        disabled={loading}
        className="bg-indigo-600 text-white px-6 py-2 rounded text-sm font-medium hover:bg-indigo-700 disabled:opacity-50"
      >
        {loading ? 'Saving...' : submitLabel}
      </button>
    </form>
  );
}
