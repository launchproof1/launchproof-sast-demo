-- FIXTURE — deliberately vulnerable migration for the SAST test suite.

-- A table WITH RLS enabled and a correct owner policy (should NOT be flagged).
create table if not exists safe_notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id),
  body text
);
alter table safe_notes enable row level security;
create policy "safe_notes_own" on safe_notes for select using (auth.uid() = user_id);

-- A table with NO RLS enabled (should be flagged: rls-not-enabled).
create table if not exists customer_secrets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  api_key text
);

-- A table with RLS enabled but a wide-open policy (should be flagged:
-- rls-policy-using-true).
create table if not exists profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  display_name text
);
alter table profiles enable row level security;
create policy "profiles_all" on profiles for select using (true);
