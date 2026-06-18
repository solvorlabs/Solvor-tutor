'use client';

import AuthGuard from '@/components/AuthGuard';
import AdminLayout from '@/components/AdminLayout';
import QuestionTable from '@/components/QuestionTable';

export default function QuestionsPage() {
  return (
    <AuthGuard>
      <AdminLayout>
        <h2 className="text-lg font-semibold mb-4">All Questions</h2>
        <QuestionTable />
      </AdminLayout>
    </AuthGuard>
  );
}
