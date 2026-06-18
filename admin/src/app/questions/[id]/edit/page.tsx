'use client';

import { useParams, useRouter } from 'next/navigation';
import { useState, useEffect } from 'react';
import AuthGuard from '@/components/AuthGuard';
import AdminLayout from '@/components/AdminLayout';
import QuestionForm from '@/components/QuestionForm';
import { api } from '@/lib/api';

export default function EditQuestionPage() {
  const { id } = useParams<{ id: string }>();
  const router = useRouter();
  const [question, setQuestion] = useState<Record<string, unknown> | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.questions.get(id)
      .then(setQuestion)
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [id]);

  async function handleSubmit(data: Record<string, unknown>) {
    await api.questions.update(id, data);
    router.push('/questions');
  }

  if (loading) {
    return (
      <AuthGuard>
        <AdminLayout>
          <p className="text-gray-500">Loading question...</p>
        </AdminLayout>
      </AuthGuard>
    );
  }

  if (!question) {
    return (
      <AuthGuard>
        <AdminLayout>
          <p className="text-red-500">Question not found.</p>
        </AdminLayout>
      </AuthGuard>
    );
  }

  return (
    <AuthGuard>
      <AdminLayout>
        <h2 className="text-lg font-semibold mb-4">Edit Question</h2>
        <QuestionForm initialData={question} onSubmit={handleSubmit} submitLabel="Update Question" />
      </AdminLayout>
    </AuthGuard>
  );
}
