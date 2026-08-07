-- ═══════════════════════════════════════════════════════
-- MANTEWORK · Configuración de base de datos Supabase
-- Ejecutar UNA VEZ en: SQL Editor del proyecto Supabase
-- ═══════════════════════════════════════════════════════

-- Tabla única con el estado completo del sitio
create table if not exists mantework_datos (
  id integer primary key,
  pack jsonb not null,
  actualizado timestamptz default now()
);

-- Fila inicial vacía
insert into mantework_datos (id, pack)
values (1, '{"avisos":[],"clientes":[]}')
on conflict (id) do nothing;

-- Actualizar la marca de tiempo en cada escritura
create or replace function tocar_actualizado()
returns trigger as $$
begin
  new.actualizado = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_tocar on mantework_datos;
create trigger trg_tocar
before update on mantework_datos
for each row execute function tocar_actualizado();

-- ═══════════════════════════════════════════════════════
-- Seguridad de acceso (RLS)
-- Permite leer y escribir solo la fila 1 con la clave anon.
-- ═══════════════════════════════════════════════════════

alter table mantework_datos enable row level security;

drop policy if exists "leer_datos" on mantework_datos;
create policy "leer_datos" on mantework_datos
  for select using (id = 1);

drop policy if exists "escribir_datos" on mantework_datos;
create policy "escribir_datos" on mantework_datos
  for insert with check (id = 1);

drop policy if exists "actualizar_datos" on mantework_datos;
create policy "actualizar_datos" on mantework_datos
  for update using (id = 1) with check (id = 1);

-- Listo. Ahora copia la URL del proyecto y la clave "anon public"
-- desde Settings → API, y pégalas en index.html:
--   const SUPABASE_URL = 'https://TUPROYECTO.supabase.co';
--   const SUPABASE_KEY = 'eyJ...';
