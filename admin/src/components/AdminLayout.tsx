'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { ReactNode } from 'react';
import { clearToken } from '@/lib/auth';

const navItems = [
  { href: '/questions', label: 'Questions' },
  { href: '/questions/new', label: 'New Question' },
  { href: '/import', label: 'Import' },
  { href: '/taxonomy', label: 'Taxonomy' },
  { href: '/analytics', label: 'Analytics' },
];

export default function AdminLayout({ children }: { children: ReactNode }) {
  const pathname = usePathname();

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 flex items-center justify-between h-14">
          <div className="flex items-center gap-6">
            <Link href="/questions" className="font-bold text-lg text-indigo-600">
              Solvor Admin
            </Link>
            {navItems.map((item) => {
              const active = pathname === item.href || pathname.startsWith(item.href + '/');
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={`text-sm font-medium ${
                    active ? 'text-indigo-600' : 'text-gray-600 hover:text-gray-900'
                  }`}
                >
                  {item.label}
                </Link>
              );
            })}
          </div>
          <button
            onClick={() => { clearToken(); window.location.href = '/login'; }}
            className="text-sm text-gray-500 hover:text-red-600"
          >
            Logout
          </button>
        </div>
      </nav>
      <main className="max-w-7xl mx-auto px-4 py-6">{children}</main>
    </div>
  );
}
