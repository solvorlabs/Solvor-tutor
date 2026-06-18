'use client';

import AuthGuard from '@/components/AuthGuard';
import AdminLayout from '@/components/AdminLayout';
import TaxonomyTree from '@/components/TaxonomyTree';

export default function TaxonomyPage() {
  return (
    <AuthGuard>
      <AdminLayout>
        <h2 className="text-lg font-semibold mb-4">Taxonomy Manager</h2>
        <TaxonomyTree />
      </AdminLayout>
    </AuthGuard>
  );
}
