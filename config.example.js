// Opcional: copia este archivo como config.js para no escribir los datos
// en cada navegador. Si no existe, la conexión se configura desde la app
// (botón de conexión, arriba a la derecha).
//
// La clave anon es pública por diseño: los datos los protege el inicio de
// sesión (RLS en supabase/schema.sql). Nunca pongas aquí la clave service_role.
window.RIFA_CONFIG = {
  url: 'https://TU-PROYECTO.supabase.co',
  anonKey: 'TU-CLAVE-ANON'
};
