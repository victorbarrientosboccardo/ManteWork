# MANTEWORK · Corpus de publicación

**Versión 3.0.0** — Sitio web y aplicación instalable en Android e iOS.

Un solo archivo `index.html` cumple ambas funciones. Los demás archivos le dan la capacidad de instalarse como app. No son dos productos separados.

---

## Estado de la versión 3.0.0

Verificada con **suite de pruebas automatizada**: 33 comprobaciones funcionales en 6 escenarios + 500 simulaciones de 30 empresas en los 5 planes (cuotas exactas, cero errores) + auditoría de accesibilidad axe-core sin violaciones.

Novedades 2.19–2.20: captación web solo desde portales del titular del aviso (con link de postulación directo), grupos ocupacionales del formulario ajustados según el perfil de cada cuenta, etiqueta "Precio de lanzamiento" en los 4 planes pagados con cláusula de protección de ciclos pagados en Términos, y posicionamiento unificado como el portal del empleo técnico en minería, textos de requisitos sugeridos por perfil (v2.21), y BASE DE DATOS EN LA NUBE activada (v3.0.0): avisos y empresas se guardan en Supabase y se ven desde todos los dispositivos, con el navegador como respaldo sin conexión.

Incluye: ciclo de planes con renovación (↻ Renovar plan reinicia el contador), corrección y reenvío de avisos en aclaración (mismo N° MNT), plan contratado fijo en el formulario, control de cuota en el botón Publicar, tarjeta de vista previa al compartir por WhatsApp, 8 avisos de captación web pendientes de validación, botones de email para recordatorio de término y confirmación de plan, y Términos que reflejan el consumo del plan por avisos (no por calendario).


## Contenido del paquete

| Archivo | Función | Tamaño |
|---|---|---|
| `index.html` | Sitio completo — 3 perfiles de acceso, 5 planes, panel admin, base de certificaciones de 130 avisos reales, captación web y suite de pruebas verificada | 246 KB |
| `manifest.json` | Define la app: nombre, íconos, colores, pantalla completa | 783 B |
| `sw.js` | Service worker — funcionamiento sin conexión y actualizaciones | 1 KB |
| `icon-192.png` | Ícono en pantalla de inicio | 2 KB |
| `icon-512.png` | Pantalla de carga (splash) | 6 KB |
| `icon-maskable-512.png` | Ícono adaptativo de Android | 5 KB |
| `apple-touch-icon.png` | Ícono de iPhone y iPad | 2 KB |
| `.nojekyll` | Archivo vacío — evita que GitHub procese mal los archivos | 0 B |
| `supabase_setup.sql` | Script para crear la base de datos en la nube (opcional) | 2 KB |
| `GUIA_SUPABASE.md` | Guía de activación de la nube en 15 minutos | 4 KB |

**Los 8 archivos van juntos en la raíz del repositorio.** Si separas alguno o los pones en subcarpetas, la instalación como app deja de funcionar.

---

## Paso 1 — Publicar en GitHub Pages

1. Crear cuenta en `github.com` si no la tienes.
2. Crear un repositorio **público** llamado `mantework`.
3. Clic en **uploading an existing file** y arrastrar los 8 archivos.
4. Escribir un mensaje de confirmación y **Commit changes**.
5. Ir a **Settings** → **Pages**.
6. En **Source**: `Deploy from a branch`, rama `main`, carpeta `/ (root)`. Guardar.
7. Esperar 2 minutos. El sitio queda en `https://TUUSUARIO.github.io/mantework/`

---

## Paso 2 — Conectar mantework.com

El dominio `.com` no se registra en NIC.cl. Usa un registrador internacional:

| Registrador | Precio aprox. | Nota |
|---|---|---|
| Cloudflare Registrar | USD $10/año | Vende a precio de costo |
| Namecheap | USD $12/año | El más simple de configurar |
| GoDaddy | Variable | Revisar el precio del **segundo** año |

Regístralo a nombre de **Invictum SPA**. Activa la protección de privacidad WHOIS (suele ser gratuita) para que el RUT y la dirección no queden públicos.

En el panel DNS del registrador, cuatro registros tipo **A** apuntando a `@`:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

Un registro **CNAME** para `www` apuntando a `TUUSUARIO.github.io`

En GitHub: **Settings** → **Pages** → **Custom domain** → `mantework.com` → Save. Marcar **Enforce HTTPS**.

La propagación DNS toma entre 1 y 24 horas.

**Recomendación:** registrar también `mantework.cl` en nic.cl (~$6.000 CLP/año) y redirigirlo a `.com`. Muchos usuarios chilenos escriben `.cl` por reflejo.

---

## Paso 3 — Instalación como app

### Android · Chrome

1. Abrir `https://mantework.com`
2. Aparece el botón dorado **📱 Instalar app** al fondo de la página
3. Tocar → Confirmar
4. El ícono hexagonal queda en la pantalla de inicio

Si el botón no aparece: menú de Chrome (⋮) → **Agregar a pantalla de inicio**

### iPhone y iPad · Safari

Safari no muestra botón automático. El usuario debe:

1. Abrir `https://mantework.com` en **Safari** (no funciona desde Chrome en iOS)
2. Tocar el botón compartir (cuadrado con flecha hacia arriba)
3. Desplazar y tocar **Agregar a pantalla de inicio**

### Computador · Chrome o Edge

Aparece un ícono de instalación en la barra de direcciones, a la derecha.

**Requisito indispensable:** la instalación solo funciona sobre HTTPS. GitHub Pages lo entrega automáticamente. Si abres el archivo localmente (`file://`), el botón no aparecerá — es normal.

---

## Paso 4 — Cómo actualizar

Cada vez que publiques una versión nueva:

1. Subir el `index.html` actualizado a GitHub.
2. **Obligatorio:** abrir `sw.js` y subir el número de versión en la línea 3:
   ```js
   const CACHE = 'mantework-v2.11.3';   // subir el número
   ```
3. Subir también el `sw.js` modificado.

Sin el paso 2, las apps ya instaladas seguirán mostrando la versión antigua desde su caché.

Las apps instaladas se actualizan solas la próxima vez que se abran con conexión.

---

## Pendientes antes de publicar

- [ ] Reemplazar los **6 placeholders** `+56 9 XXXX XXXX` por el número real del canal
- [ ] Reemplazar el mensaje "disponible al lanzar" por el link real del canal de WhatsApp
- [ ] **Cambiar las 4 claves demo** — están visibles en el código fuente
- [ ] Activar Webpay Plus en transbank.cl con el RUT de Invictum SPA (5 a 10 días hábiles)
- [ ] Verificar que el giro de Invictum SPA en el SII cubra servicios digitales o publicidad

---

## Credenciales de prueba incluidas

| Perfil | Usuario | Clave |
|---|---|---|
| Administrador | `admin` | `Mante2026` |
| Codelco El Salvador · Pack Empresa | `rrhh@codelco-elsalvador.cl` | `Codelco2026` |
| Codelco El Salvador · segundo usuario | `seleccion@codelco-elsalvador.cl` | `Codelco2026b` |
| Epiroc Chile · Plan Estándar | `empleo@epiroc.cl` | `Epiroc2026` |
| Minera Prueba SpA · sin cobro | `demo@mantework.com` | `Demo2026` |

**Cámbialas antes de publicar en producción.**

---

## Funciones preparadas pero desactivadas

Tres funciones están completas en el código pero apagadas a propósito. Cada una indica en un comentario cómo activarla.

**Asistente de redacción con IA** — el botón "✨ Mejorar redacción" del campo de requisitos. Necesita un backend que guarde la clave de API (Cloudflare Workers o Vercel, ambos con plan gratuito suficiente). Sin backend, la llamada falla porque no hay autenticación. Poner la clave directamente en el HTML no es opción: quedaría visible para cualquiera.

Mientras tanto, el botón "📋 Ver ejemplos" cumple esa función sin costo: 13 ejemplos según el perfil CCM elegido, editables antes de insertar. Y las certificaciones del formulario ya vienen ordenadas por su frecuencia real en 130 avisos de la gran minería (BHP, Codelco, AMSA, SQM, AngloAmerican, Teck, Kinross) — respaldo documental en el Excel Certificaciones_avisos_reales_CCM.xlsx.

**Opción A de enrolamiento** — permitiría que las empresas soliciten acceso por sí mismas en lugar de que tú las enroles. Conviene activarla al superar las 50 empresas.

**Base de datos en la nube (Supabase)** — la integración ya está incluida en el código, desactivada. Al activarla, los avisos de las empresas llegan a tu panel al instante desde cualquier dispositivo. Sigue la guía `GUIA_SUPABASE.md` (15 minutos, costo $0). Mientras no la actives, los datos se guardan en cada navegador con respaldo descargable.

Ninguna impide publicar. El sitio funciona completo con los tres perfiles de acceso.

---

## Si más adelante quieres publicarla en Google Play

Como ya tienes cuenta de Play Console, puedes empaquetar este mismo sitio sin reprogramar nada:

1. Entrar a `pwabuilder.com`
2. Pegar la URL `https://mantework.com`
3. Descargar el paquete Android (genera un `.aab` firmado)
4. Subirlo a Play Console

Se llama TWA (Trusted Web Activity) y es tu mismo sitio dentro de un contenedor nativo. Toma unos 20 minutos.

**Consideración:** Google exige que las apps TWA aporten valor más allá del sitio web. En esta etapa, la instalación directa desde el navegador es suficiente y evita el proceso de revisión en cada actualización.
