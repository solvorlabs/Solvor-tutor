'use client';

import AuthGuard from '@/components/AuthGuard';
import AdminLayout from '@/components/AdminLayout';
import AnalyticsTable from '@/components/AnalyticsTable';

export default function AnalyticsPage() {
  return (
    <AuthGuard>
      <AdminLayout>
        <h2 className="text-lg font-semibold mb-4">Attempt Analytics</h2>
        <AnalyticsTable />
      </AdminLayout>
    </AuthGuard>
  );
}
