-- Esquema para el control de reparto de listas de rifa.
-- Pégalo en Supabase: SQL Editor > New query > Run.

create table if not exists personas (
  id        uuid primary key default gen_random_uuid(),
  nombre    text not null,
  telefono  text not null default '',
  notas     text not null default '',
  creado    timestamptz not null default now()
);

-- Una fila por número de lista.
create table if not exists listas (
  numero        int primary key check (numero > 0),
  persona_id    uuid references personas(id) on delete set null,
  fecha_entrega date,
  vendidos      int not null default 0 check (vendidos >= 0),
  monto         numeric(10,2) not null default 0 check (monto >= 0),
  devuelta      boolean not null default false,
  perdida       boolean not null default false,
  notas         text not null default '',
  actualizado   timestamptz not null default now()
);

create index if not exists listas_persona_idx on listas(persona_id);

-- Solo los organizadores con sesión iniciada pueden leer y escribir.
alter table personas enable row level security;
alter table listas   enable row level security;

drop policy if exists "organizadores personas" on personas;
create policy "organizadores personas" on personas
  for all to authenticated using (true) with check (true);

drop policy if exists "organizadores listas" on listas;
create policy "organizadores listas" on listas
  for all to authenticated using (true) with check (true);

-- Cambios en tiempo real entre organizadores.
alter publication supabase_realtime add table personas, listas;
