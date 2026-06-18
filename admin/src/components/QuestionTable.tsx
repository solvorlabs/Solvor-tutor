'use client';

import Link from 'next/link';
import { useState, useEffect } from 'react';
import { api, Question } from '@/lib/api';

export default function QuestionTable() {
  const [questions, setQuestions] = useState<Question[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [difficulty, setDifficulty] = useState('');
  const [loading, setLoading] = useState(true);
  const limit = 20;

  useEffect(() => {
    setLoading(true);
    const params = new URLSearchParams({ page: String(page), limit: String(limit) });
    if (search) params.set('search', search);
    if (difficulty) params.set('difficulty', difficulty);

    api.questions.list(params.toString())
      .then((data) => {
        setQuestions(data.questions);
        setTotal(data.pagination.total);
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [page, search, difficulty]);

  const totalPages = Math.ceil(total / limit);

  return (
    <div>
      <div className="flex gap-3 mb-4">
        <input
          type="text"
          placeholder="Search by question text..."
          className="border rounded px-3 py-2 flex-1 text-sm"
          value={search}
          onChange={(e) => { setSearch(e.target.value); setPage(1); }}
        />
        <select
          className="border rounded px-3 py-2 text-sm"
          value={difficulty}
          onChange={(e) => { setDifficulty(e.target.value); setPage(1); }}
        >
          <option value="">All Difficulties</option>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
      </div>

      {loading ? (
        <p className="text-gray-500">Loading...</p>
      ) : (
        <>
          <div className="overflow-x-auto bg-white rounded shadow">
            <table className="w-full text-sm">
              <thead className="bg-gray-100">
                <tr>
                  <th className="text-left px-4 py-2 font-medium">Question (EN)</th>
                  <th className="text-left px-4 py-2 font-medium">Question (HI)</th>
                  <th className="text-left px-4 py-2 font-medium">Difficulty</th>
                  <th className="text-left px-4 py-2 font-medium">Actions</th>
                </tr>
              </thead>
              <tbody>
                {questions.map((q) => (
                  <tr key={q.id} className="border-t hover:bg-gray-50">
                    <td className="px-4 py-2 max-w-xs truncate">{q.questionEn}</td>
                    <td className="px-4 py-2 max-w-xs truncate">{q.questionHi}</td>
                    <td className="px-4 py-2">
                      <span className={`text-xs font-medium px-2 py-1 rounded ${
                        q.difficultyLevel === 'easy' ? 'bg-green-100 text-green-700' :
                        q.difficultyLevel === 'hard' ? 'bg-red-100 text-red-700' :
                        'bg-yellow-100 text-yellow-700'
                      }`}>
                        {q.difficultyLevel}
                      </span>
                    </td>
                    <td className="px-4 py-2">
                      <Link
                        href={`/questions/${q.id}/edit`}
                        className="text-indigo-600 hover:underline text-xs"
                      >
                        Edit
                      </Link>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="flex items-center justify-between mt-4 text-sm">
            <span className="text-gray-500">
              Page {page} of {totalPages} ({total} total)
            </span>
            <div className="flex gap-2">
              <button
                disabled={page <= 1}
                onClick={() => setPage(page - 1)}
                className="px-3 py-1 border rounded disabled:opacity-40"
              >
                Previous
              </button>
              <button
                disabled={page >= totalPages}
                onClick={() => setPage(page + 1)}
                className="px-3 py-1 border rounded disabled:opacity-40"
              >
                Next
              </button>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
