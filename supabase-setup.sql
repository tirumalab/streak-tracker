-- Run this once in your Supabase project's SQL Editor
-- (Dashboard -> SQL Editor -> New query -> paste -> Run)

create table streak_data (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

alter table streak_data enable row level security;

-- Open read/write for the anon key, since this is a private 2-person
-- app that isn't meant to be discoverable — no login system on top.
-- Anyone who has your deployed URL *and* digs the anon key out of the
-- page source could read or write this table. Fine for a hobby project
-- between two people; don't reuse this table/policy for anything sensitive.
create policy "anon can read" on streak_data
  for select using (true);

create policy "anon can insert" on streak_data
  for insert with check (true);

create policy "anon can update" on streak_data
  for update using (true);
