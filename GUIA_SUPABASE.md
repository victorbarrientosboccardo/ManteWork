> **ESTADO: ACTIVADO (07-08-2026)** — Proyecto "ManteWork" (`tdbjlewbaxmqyueszmnu`). Las credenciales ya están dentro de `index.html`; esta guía queda como referencia de mantenimiento.

# MANTEWORK · Activar la base de datos en la nube (Supabase)

Con esto, los avisos que publiquen las empresas **llegan a tu panel al instante**, y lo que apruebes se ve en todos los dispositivos. Los datos dejan de vivir en cada navegador y pasan a una base compartida.

**Costo: $0.** El plan gratuito de Supabase incluye 500 MB de base de datos — suficiente para años de avisos de MANTEWORK.

**Tiempo estimado: 15 minutos.**

---

## Paso 1 — Crear el proyecto

1. Entra a `supabase.com` y crea una cuenta (puedes usar tu cuenta de GitHub).
2. Clic en **New project**.
3. Nombre: `mantework` · Región: **South America (São Paulo)** — la más cercana a Chile.
4. Define una contraseña de base de datos (guárdala, aunque no la usarás a diario).
5. Espera 2 minutos mientras se crea.

## Paso 2 — Crear la tabla

1. En el menú izquierdo, clic en **SQL Editor**.
2. Abre el archivo `supabase_setup.sql` de este paquete, copia todo su contenido.
3. Pégalo en el editor y presiona **Run**.
4. Debe decir "Success. No rows returned".

Esto crea la tabla, la fila inicial y las reglas de seguridad de acceso.

## Paso 3 — Conectar el sitio

1. En Supabase: **Settings** → **API**.
2. Copia dos datos:
   - **Project URL** (algo como `https://abcdefgh.supabase.co`)
   - **anon public** key (una cadena larga que empieza con `eyJ`)
3. Abre `index.html` y busca estas dos líneas (están cerca del inicio del script, sección SUPABASE):

```js
const SUPABASE_URL = '';   // ej: 'https://abcdefgh.supabase.co'
const SUPABASE_KEY = '';   // la clave "anon public"
```

4. Pega tus valores entre las comillas:

```js
const SUPABASE_URL = 'https://abcdefgh.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6...';
```

5. Guarda, sube el `index.html` actualizado a GitHub (y sube la versión en `sw.js`).

## Paso 4 — Verificar

1. Abre el sitio, entra como admin.
2. En la sección "💾 Datos y respaldos" debe aparecer **☁ Sincronizado** en verde.
3. Prueba real: enrola una empresa desde tu computador, luego abre el sitio desde tu celular e inicia sesión como admin — la empresa debe aparecer.

---

## Cómo funciona

- **Al abrir el sitio**, carga primero los datos de la nube. Si la nube no responde (sin internet), usa la copia local del navegador.
- **Cada cambio** (enrolar, aprobar, editar) se guarda en el navegador al instante y se sube a la nube automáticamente.
- **Antes de publicar un aviso**, el sitio refresca desde la nube para no pisar publicaciones simultáneas de otras empresas.
- **El respaldo descargable** sigue funcionando igual — sigue siendo tu seguro adicional.

## ¿Es seguro pegar la clave "anon" en el HTML?

Sí, esa clave está **diseñada para ser pública** — es la clave de cliente de Supabase. Lo que protege los datos no es la clave sino las reglas RLS que creó el script: solo permiten leer y escribir la fila de datos de MANTEWORK, nada más del proyecto.

**Limitación honesta que debes conocer:** con esta arquitectura, cualquier persona con conocimientos técnicos podría leer los datos de la tabla (incluidas las contraseñas de las empresas, que siguen en texto plano). Para el volumen y la etapa actual del negocio es un riesgo acotado. El paso siguiente de seguridad —cuando tengas decenas de empresas pagando— es migrar el login a **Supabase Auth**, que cifra las contraseñas y las saca por completo del alcance del cliente. Ese es un trabajo de una sesión aparte.

## Si algo falla

- **"⚠ Sin conexión con la nube"** en el panel: revisa que la URL y la clave estén bien pegadas, sin espacios al inicio o final.
- Los cambios no aparecen en otro dispositivo: recarga la página (el sitio carga la nube al abrir, no en tiempo real continuo).
- Todo lo demás sigue funcionando en modo local — la nube nunca bloquea el sitio.
