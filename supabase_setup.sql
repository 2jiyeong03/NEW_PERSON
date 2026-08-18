-- 선입선출 앱: Supabase 초기 설정 SQL
-- Supabase 대시보드 > SQL Editor 에 붙여넣고 실행하세요.

create table public.ingredients (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  name text not null,
  expiry_date date not null,
  consumed boolean not null default false,
  consumed_at timestamptz,
  discarded boolean not null default false,
  discarded_at timestamptz,
  created_at timestamptz not null default now()
);

alter table public.ingredients enable row level security;

create policy "Users manage their own ingredients"
  on public.ingredients
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
