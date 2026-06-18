'use client';

import { useRouter } from 'next/navigation';
import AuthGuard from '@/components/AuthGuard';
import AdminLayout from '@/components/AdminLayout';
import QuestionForm from '@/components/QuestionForm';
import { api } from '@/lib/api';

export default function NewQuestionPage() {
  const router = useRouter();

  async function handleSubmit(data: Record<string, unknown>) {
    await api.questions.create(data);
    router.push('/questions');
  }

  return (
    <AuthGuard>
      <AdminLayout>
        <h2 className="text-lg font-semibold mb-4">New Question</h2>
        <QuestionForm onSubmit={handleSubmit} submitLabel="Create Question" />
      </AdminLayout>
    </AuthGuard>
  );
}
