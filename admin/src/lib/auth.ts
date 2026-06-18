'use client';

import { useState, useEffect, useCallback } from 'react';

const TOKEN_KEY = 'admin_token';
const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';

export function getStoredToken(): string | null {
  if (typeof window === 'undefined') return null;
  return localStorage.getItem(TOKEN_KEY);
}

export function setStoredToken(token: string): void {
  localStorage.setItem(TOKEN_KEY, token);
}

export function clearToken(): void {
  localStorage.removeItem(TOKEN_KEY);
}

export function isAuthenticated(): boolean {
  const token = getStoredToken();
  if (!token) return false;
  try {
    const payload = JSON.parse(atob(token.split('.')[1]));
    return payload.exp * 1000 > Date.now();
  } catch {
    return false;
  }
}

export async function login(phoneNumber: string, otp: string): Promise<string> {
  const registerRes = await fetch(`${API_URL}/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ phoneNumber }),
  });
  const registerData = await registerRes.json();
  if (!registerRes.ok) throw new Error(registerData.error);

  const verifyRes = await fetch(`${API_URL}/auth/verify-otp`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ phoneNumber, otp }),
  });
  const verifyData = await verifyRes.json();
  if (!verifyRes.ok) throw new Error(verifyData.error);

  return verifyData.token;
}

export function useAuth() {
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setToken(getStoredToken());
    setLoading(false);
  }, []);

  const loginAction = useCallback(async (phone: string, otp: string) => {
    const t = await login(phone, otp);
    setStoredToken(t);
    setToken(t);
    return t;
  }, []);

  const logout = useCallback(() => {
    clearToken();
    setToken(null);
  }, []);

  return { token, loading, isLoggedIn: !!token && isAuthenticated(), login: loginAction, logout };
}
