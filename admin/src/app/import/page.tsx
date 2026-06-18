'use client';

import AuthGuard from '@/components/AuthGuard';
import AdminLayout from '@/components/AdminLayout';
import ImportWizard from '@/components/ImportWizard';

export default function ImportPage() {
  return (
    <AuthGuard>
      <AdminLayout>
        <h2 className="text-lg font-semibold mb-4">Bulk Import Questions</h2>
        <ImportWizard />
      </AdminLayout>
    </AuthGuard>
  );
}
