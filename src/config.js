// src/config.js — demo of a common Supabase mistake.
import { createClient } from "@supabase/supabase-js";

const url = import.meta.env.VITE_SUPABASE_URL;

// BUG: the service-role key bypasses Row Level Security and must never be
// used in client code. Exposed here via a browser-visible env var.
export const admin = createClient(url, import.meta.env.VITE_SUPABASE_SERVICE_ROLE_KEY);

export const anon = createClient(url, import.meta.env.VITE_SUPABASE_ANON_KEY);
