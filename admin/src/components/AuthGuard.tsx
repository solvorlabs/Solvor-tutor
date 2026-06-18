'use client';

import { useAuth } from '@/lib/auth';
import { useRouter } from 'next/navigation';
import { ReactNode, useEffect } from 'react';

export default function AuthGuard({ children }: { children: ReactNode }) {
  const { loading, isLoggedIn } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!loading && !isLoggedIn) {
      router.replace('/login');
    }
  }, [loading, isLoggedIn, router]);

  if (loading || !isLoggedIn) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <p className="text-gray-500">Loading...</p>
      </div>
    );
  }

  return <>{children}</>;
}
