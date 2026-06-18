'use client';

import { useState, useEffect } from 'react';
import { api } from '@/lib/api';

interface Row {
  questionId: string;
  questionText: string;
  totalAttempts: number;
  correctAttempts: number;
  accuracyRate: number;
  avgTimeSeconds: number;
  difficultyLevel: string;
  topicName: string;
}

export default function AnalyticsTable() {
  const [rows, setRows] = useState<Row[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.analytics.get()
      .then((data) => setRows(data.rows as Row[]))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <p className="text-gray-500">Loading analytics...</p>;

  return (
    <div className="bg-white rounded shadow overflow-x-auto">
      <table className="w-full text-sm">
        <thead className="bg-gray-100">
          <tr>
            <th className="text-left px-4 py-2">Question</th>
            <th className="text-left px-4 py-2">Topic</th>
            <th className="text-left px-4 py-2">Difficulty</th>
            <th className="text-right px-4 py-2">Attempts</th>
            <th className="text-right px-4 py-2">Accuracy</th>
            <th className="text-right px-4 py-2">Avg Time (s)</th>
          </tr>
        </thead>
        <tbody>
          {rows.length === 0 ? (
            <tr>
              <td colSpan={6} className="text-center py-8 text-gray-400">
                No attempt data yet.
              </td>
            </tr>
          ) : (
            rows.map((r) => (
              <tr key={r.questionId} className="border-t hover:bg-gray-50">
                <td className="px-4 py-2 max-w-xs truncate">{r.questionText}</td>
                <td className="px-4 py-2">{r.topicName}</td>
                <td className="px-4 py-2">
                  <span className={`text-xs font-medium px-2 py-1 rounded ${
                    r.difficultyLevel === 'easy' ? 'bg-green-100 text-green-700' :
                    r.difficultyLevel === 'hard' ? 'bg-red-100 text-red-700' :
                    'bg-yellow-100 text-yellow-700'
                  }`}>
                    {r.difficultyLevel}
                  </span>
                </td>
                <td className="text-right px-4 py-2">{r.totalAttempts}</td>
                <td className="text-right px-4 py-2">
                  <span className={`font-medium ${
                    r.accuracyRate >= 70 ? 'text-green-600' :
                    r.accuracyRate >= 40 ? 'text-yellow-600' : 'text-red-600'
                  }`}>
                    {(r.accuracyRate * 100).toFixed(1)}%
                  </span>
                </td>
                <td className="text-right px-4 py-2">{r.avgTimeSeconds.toFixed(1)}</td>
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
}
