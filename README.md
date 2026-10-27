# Generador de listas de rifa

Herramienta web para generar e imprimir listas de rifa en hojas tamaño carta, **dos listas por hoja** (media página cada una), con letra grande y filas altas para escribir a mano.

Creada para la rifa de una canasta de víveres a beneficio de la P.C. San Miguel Arcángel, pero sirve para cualquier rifa: todos los textos se pueden cambiar.

![Hoja de ejemplo con dos listas](docs/hoja-ejemplo.png)

## Uso

No requiere instalación ni internet para funcionar.

1. Abre `index.html` en Chrome, Safari o Edge.
2. Elige el rango de listas (por ejemplo, de la 10 a la 50).
3. Ajusta los textos y la fecha.
4. Pulsa **Imprimir o guardar PDF**.

En el diálogo de impresión usa tamaño **Carta**, escala **100 %** y desactiva los encabezados y pies de página.

## Funciones

- **Rango de listas:** genera de la lista *N* a la *M*; cada hoja lleva dos.
- **Números por lista:** de 1 a 20 (10 por defecto). Menos números dan filas más altas.
- **Textos editables:** título, valor del número, beneficio, fecha del sorteo (o un texto propio) y evento o lugar.
- **Opciones:**
  - Lista ya numerada o con una raya para escribirla.
  - Línea "Vendida por".
  - Boletos seguidos (la lista 2 lleva del 11 al 20, y así).
- **Presets:** guarda y carga configuraciones con nombre. Se almacenan en el navegador (`localStorage`), por lo que no viajan entre equipos.
- **Vista previa a escala** de cada hoja, con resumen de listas, hojas y recaudo si se vende todo.
- **Modo oscuro** automático en la interfaz; la hoja impresa siempre es blanca.

## Reparto y control

La pestaña **Reparto y control** sirve para saber en manos de quién está cada lista.

- **Entregar listas:** escribe el nombre, el teléfono y los números (`1-10`, `4, 7, 12-15`). Avisa si alguna ya estaba entregada.
- **Seguimiento por lista:** cuántos números vendió, cuánto dinero entregó, si devolvió la hoja o si se perdió. Cada lista queda como *Sin entregar*, *Con vendedor*, *Devuelta, falta dinero*, *Completa* o *Perdida*.
- **Resumen:** listas sin entregar, con vendedores, devueltas y perdidas; números vendidos; dinero recibido y por cobrar (usa el valor del número y los números por lista de la pestaña Imprimir).
- **Por persona:** cuántas listas tiene cada quien, cuántas debe devolver y cuánto dinero debe. Un clic filtra sus listas.
- **Filtros, búsqueda y exportar a CSV.**

Sin configurar nada funciona en **modo local** (los datos quedan en ese navegador). Para que varios organizadores compartan el mismo control, conecta Supabase.

### Conectar Supabase (gratis)

1. Crea un proyecto en [supabase.com](https://supabase.com) (el plan gratuito alcanza).
2. En **SQL Editor** pega y ejecuta [`supabase/schema.sql`](supabase/schema.sql). Crea las tablas, activa la seguridad por filas y habilita los cambios en tiempo real.
3. En **Authentication > Providers > Email** desactiva *Allow new users to sign up* y, en **Authentication > Users**, crea un usuario (correo y contraseña) por cada organizador.
4. En **Project Settings > API** copia la *Project URL* y la clave *anon public*.
5. En la app pulsa el botón de conexión (arriba a la derecha), pega los dos datos y entra con tu correo.

Para no repetir el paso 5 en cada navegador, copia `config.example.js` como `config.js` con esos datos. La clave anon es pública por diseño: lo que protege los datos es el inicio de sesión. Nunca uses la clave `service_role` en el navegador.

Con la app publicada (por ejemplo en GitHub Pages), cada organizador abre el enlace y entra con su cuenta.

## Estructura

```
index.html          # toda la aplicación (HTML, CSS y JS)
config.example.js   # ejemplo de configuración de Supabase (opcional)
supabase/schema.sql # tablas y reglas de seguridad
docs/               # imágenes del README
```

## Valores por defecto

| Campo | Valor |
|---|---|
| Título | GRAN RIFA DE UNA CANASTA DE VÍVERES |
| Valor del número | $0.50 |
| Beneficio | A beneficio de la P.C. San Miguel Arcángel |
| Fecha | 20 de noviembre |
| Evento | Asamblea de P.C. San Miguel Arcángel |

Se cambian en el panel o en los atributos `value` de `index.html`.

## Notas técnicas

- Sin paso de compilación. La única dependencia es `supabase-js` (cargada desde jsDelivr, solo se usa si configuras Supabase). Las fuentes de la interfaz vienen de Google Fonts y tienen alternativas locales si no hay conexión.
- La hoja impresa usa Helvetica/Arial y unidades físicas (`in`, `pt`), con `@page { size: letter }`, para que el resultado sea igual en cualquier navegador.
