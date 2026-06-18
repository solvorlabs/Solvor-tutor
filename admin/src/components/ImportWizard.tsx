'use client';

import { useState, useRef } from 'react';
import { api } from '@/lib/api';

export default function ImportWizard() {
  const [jsonText, setJsonText] = useState('');
  const [result, setResult] = useState<{ inserted: number; failed: number; errors: { row: number; message: string }[] } | null>(null);
  const [loading, setLoading] = useState(false);
  const fileRef = useRef<HTMLInputElement>(null);

  function handleFileUpload(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (ev) => {
      setJsonText(ev.target?.result as string);
    };
    reader.readAsText(file);
  }

  async function handleImport() {
    setLoading(true);
    setResult(null);
    try {
      let questions: Record<string, unknown>[];
      try {
        questions = JSON.parse(jsonText);
        if (!Array.isArray(questions)) {
          const parsed = JSON.parse(jsonText);
          questions = parsed.questions || parsed.data || [parsed];
        }
      } catch {
        const lines = jsonText.split('\n').filter((l) => l.trim());
        const headers = lines[0].split(',').map((h) => h.trim());
        questions = lines.slice(1).map((line) => {
          const vals = line.split(',').map((v) => v.trim());
          const obj: Record<string, unknown> = {};
          headers.forEach((h, i) => { obj[h] = vals[i]; });
          return obj;
        });
      }

      const data = await api.admin.importQuestions(questions);
      setResult(data);
    } catch (err) {
      setResult({ inserted: 0, failed: 1, errors: [{ row: 0, message: String(err) }] });
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="space-y-4">
      <div className="bg-white rounded shadow p-4">
        <h3 className="font-medium mb-2">Upload File</h3>
        <input
          ref={fileRef}
          type="file"
          accept=".json,.csv"
          onChange={handleFileUpload}
          className="text-sm"
        />
      </div>

      <div className="bg-white rounded shadow p-4">
        <h3 className="font-medium mb-2">Or paste JSON/CSV</h3>
        <textarea
          className="w-full border rounded px-3 py-2 text-sm font-mono"
          rows={12}
          value={jsonText}
          onChange={(e) => setJsonText(e.target.value)}
          placeholder='[{"question_en": "...", "question_hi": "...", ...}]'
        />
      </div>

      <button
        onClick={handleImport}
        disabled={loading || !jsonText.trim()}
        className="bg-indigo-600 text-white px-6 py-2 rounded text-sm font-medium hover:bg-indigo-700 disabled:opacity-50"
      >
        {loading ? 'Importing...' : 'Import Questions'}
      </button>

      {result && (
        <div className="bg-white rounded shadow p-4 space-y-2">
          <p className="text-sm">
            <span className="text-green-600 font-medium">Inserted: {result.inserted}</span>
            {' | '}
            <span className="text-red-600 font-medium">Failed: {result.failed}</span>
          </p>
          {result.errors.length > 0 && (
            <div>
              <p className="text-sm font-medium text-red-600">Errors:</p>
              <ul className="list-disc list-inside text-xs text-red-500 space-y-1">
                {result.errors.map((e, i) => (
                  <li key={i}>Row {e.row}: {e.message}</li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
