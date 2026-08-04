# Handoff: вбудувати кастомну 404 + фікси маршрутів у сайт

**Кому:** власнику/мейнтейнеру репозиторію сайту (`insightis-site`, з коміт-доступом).
**Навіщо:** зараз будь-який неіснуючий URL віддає сиру сторінку Vercel `404: NOT_FOUND` (без хедера/навігації/брендингу). Нижче — готова брендована 404 у стилі сайту + два пов'язані фікси маршрутів, виявлені в аудиті.

> Це можна віддати як **промпт Claude Code / іншому агенту** у корені репозиторію сайту, або зробити руками — кроки однакові.

---

## ПРОМПТ (копіювати цілком)

> Ти працюєш у репозиторії сайту Insightis (Vite + React, багатосторінковий; дев — `npm run dev`, білд — `npm run build`, деплой — Vercel, `vercel.json` без catch-all rewrite). Виконай 3 задачі й перевір результат.
>
> **Задача 1. Додати брендовану сторінку 404.**
> Створи файл `public/404.html` з таким вмістом (Vite копіює `public/*` у корінь `dist/`, а Vercel автоматично віддає `/404.html` на неіснуючих маршрутах — окремого налаштування не потрібно):
>
> ```html
> <!DOCTYPE html>
> <html lang="en">
> <head>
> <meta charset="UTF-8">
> <meta name="viewport" content="width=device-width, initial-scale=1.0">
> <link rel="icon" type="image/svg+xml" href="/favicon.svg?v=2">
> <title>Page not found — Insightis</title>
> <meta name="robots" content="noindex,follow">
> <meta name="theme-color" content="#0A0E13">
> <link rel="preload" href="/fonts/Geist-Variable.ttf" as="font" type="font/ttf" crossorigin>
> <style>
>   @font-face{ font-family:"Geist"; src:url("/fonts/Geist-Variable.ttf") format("truetype"); font-weight:100 900; font-display:swap; }
>   :root{ --page:#0A0E13; --surface:#0D1117; --heading:#E8F2F5; --text:#C0D4DC; --muted:#7FA0AC;
>     --border:rgba(255,255,255,0.06); --border-strong:rgba(255,255,255,0.10);
>     --teal-400:#0EC4C1; --teal-500:#148F8D; --teal-600:#07807E; --teal-650:#096968; }
>   *{box-sizing:border-box} html,body{height:100%}
>   body{ margin:0;background:var(--page);color:var(--text);
>     font-family:"Geist",-apple-system,BlinkMacSystemFont,"Segoe UI",system-ui,sans-serif;
>     -webkit-font-smoothing:antialiased;display:flex;flex-direction:column;min-height:100vh;
>     background-image:radial-gradient(60% 55% at 50% 0%, rgba(14,196,193,0.10), transparent 70%),
>       radial-gradient(40% 40% at 85% 100%, rgba(20,143,141,0.08), transparent 70%);
>     background-repeat:no-repeat; }
>   header{padding:22px 24px}
>   .brand{display:inline-flex;align-items:center;gap:10px;text-decoration:none;color:var(--heading)}
>   .brand img{width:26px;height:26px;display:block} .brand span{font-size:19px;font-weight:700;letter-spacing:-.01em}
>   main{flex:1;display:flex;align-items:center;justify-content:center;padding:24px}
>   .box{max-width:560px;text-align:center}
>   .code{font-size:clamp(84px,18vw,150px);line-height:.9;font-weight:800;letter-spacing:-.04em;margin:0;
>     background:linear-gradient(135deg,var(--teal-400) 0%,var(--teal-500) 55%,var(--teal-650) 100%);
>     -webkit-background-clip:text;background-clip:text;color:transparent;}
>   h1{color:var(--heading);font-size:clamp(22px,4vw,30px);letter-spacing:-.02em;margin:14px 0 10px;font-weight:700;text-wrap:balance}
>   p.lead{color:var(--muted);font-size:16px;line-height:1.6;margin:0 auto 30px;max-width:44ch;text-wrap:pretty}
>   .actions{display:flex;gap:12px;justify-content:center;flex-wrap:wrap}
>   .btn{display:inline-flex;align-items:center;gap:8px;height:44px;padding:0 22px;border-radius:999px;
>     font-size:15px;font-weight:600;text-decoration:none;transition:background .18s ease,border-color .18s ease}
>   .btn-primary{background:var(--teal-600);color:#fff;border:1px solid var(--teal-500)} .btn-primary:hover{background:var(--teal-650)}
>   .btn-ghost{background:transparent;color:var(--heading);border:1px solid var(--border-strong)}
>   .btn-ghost:hover{border-color:var(--teal-500);color:var(--teal-400)}
>   .links{margin-top:34px;padding-top:22px;border-top:1px solid var(--border)}
>   .links .t{font-size:12px;letter-spacing:.14em;text-transform:uppercase;color:var(--muted);margin-bottom:12px}
>   .links nav{display:flex;gap:8px 22px;justify-content:center;flex-wrap:wrap}
>   .links a{color:var(--text);text-decoration:none;font-size:14px;transition:color .18s ease} .links a:hover{color:var(--teal-400)}
>   footer{padding:20px 24px;text-align:center;color:var(--muted);font-size:12.5px}
>   a:focus-visible,.btn:focus-visible{outline:2px solid var(--teal-400);outline-offset:2px}
> </style>
> </head>
> <body>
>   <header><a class="brand" href="/" aria-label="Insightis home"><img src="/favicon.svg?v=2" alt=""><span>Insightis</span></a></header>
>   <main><div class="box">
>     <p class="code">404</p>
>     <h1>This page doesn’t exist</h1>
>     <p class="lead">The page you’re looking for was moved, renamed, or is still on the way. Let’s get you back to your data.</p>
>     <div class="actions">
>       <a class="btn btn-primary" href="/">Back to home</a>
>       <a class="btn btn-ghost" href="/pricing">See pricing</a>
>     </div>
>     <div class="links"><div class="t">Popular pages</div><nav>
>       <a href="/platform/ai-chat">AI Chat</a><a href="/platform/integrations">Integrations</a>
>       <a href="/platform/semantic-layer">Semantic Layer</a><a href="/docs/">Documentation</a>
>       <a href="/resources/contact-support">Support</a>
>     </nav></div>
>   </div></main>
>   <footer>© Devart — Insightis · AI Analytics Workspace</footer>
> </body>
> </html>
> ```
>
> **Задача 2. Виправити битий лінк у статичному fallback.**
> У файлі `platform/ai-chat.html` (рядок ~193) заміни:
> ```html
> <p><a href="/pricing">Start for free</a> · <a href="/integrations">See all integrations</a></p>
> ```
> на:
> ```html
> <p><a href="/auth/sign-up/">Start for free</a> · <a href="/platform/integrations">See all integrations</a></p>
> ```
> Причини: `/integrations` → 404 (правильний шлях `/platform/integrations`); лейбл «Start for free» має вести на реєстрацію, а не на `/pricing`.
>
> **Задача 3. Прибрати мертві мапи на неіснуючу сторінку.**
> У `src/components/Header.jsx` і `src/components/Footer.jsx` у обʼєкті `linkUrls` видали рядок:
> ```js
> 'Memory & Storage': '/platform/memory-storage',
> ```
> Сторінки `/platform/memory-storage` не існує (404). Пункт меню «Memory & Storage» позначений `notClickable`, тож у навігації нічого не зламається; це прибирає латентну пастку (якщо колись знімуть guard — зʼявиться битий лінк). *Альтернатива:* якщо фічу скоро релізите — створіть реальну сторінку `platform/memory-storage.html` і додайте її в `input` у `vite.config.js`.
>
> **Перевірка:**
> 1. `npm run dev`, відкрий `http://localhost:5173/404.html` — має бути темна сторінка з teal-«404», лого й кнопками.
> 2. Перевір, що з `platform/ai-chat.html` (без JS / у розмітці) обидва лінки ведуть на існуючі маршрути.
> 3. `npm run build` без помилок.
> 4. Після деплою: відкрий будь-який неіснуючий URL (напр. `/nope`) — має показатись брендована 404, а не сира Vercel.

---

## Примітки
- **Контент-фікси Pricing** (суперечність знижки 50% vs 20%; FAQ згадує неіснуючі плани Team/Enterprise) — окремо, див. `audit-findings.md` (C1, C2). Їх теж варто застосувати, але вони не стосуються цієї операції з 404.
- Файл `public/404.html` уже підготовано в робочій копії `insightis-site/` — власник може або скопіювати його, або відтворити з блоку вище у своєму репозиторії.
