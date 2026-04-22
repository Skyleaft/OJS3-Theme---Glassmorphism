# Glass Theme for OJS 3.5

> Modern **glassmorphism** theme for [Open Journal Systems](https://pkp.sfu.ca/ojs/) 3.5.  
> Built with **Tailwind CSS 4**, pure Smarty templates, and vanilla JS.

---

## Features

| Feature | Details |
|---------|---------|
| 🪟 Design | Glassmorphism — backdrop-filter blur, frosted cards |
| 🎨 Tailwind CSS 4 | CSS-native `@theme` config, no `tailwind.config.js` |
| 🌗 Dark / Light | Toggle persisted in `localStorage`; OS auto-detect |
| 🌐 Locale | English (primary) + Bahasa Indonesia (`locale/en/` · `locale/id/`) |
| ✨ Transitions | Page fade, scroll-reveal (IntersectionObserver), nav shrink |
| ⚙️ Admin Options | Accent color · Blur intensity · Default color mode |
| ♿ Accessible | ARIA landmarks, skip-to-content, focus trapping |
| 📱 Responsive | Mobile hamburger menu, fluid card grids |

---

## Directory Structure

```
plugins/themes/glassTheme/
├── GlassThemePlugin.php          ← Plugin class (ThemePlugin)
├── index.php                     ← OJS plugin bootstrap
├── version.xml                   ← Plugin metadata
│
├── package.json                  ← Node build deps
├── postcss.config.mjs            ← PostCSS → Tailwind pipeline
├── tailwind.css                  ← Tailwind 4 source (CSS-native @theme)
│
├── styles/
│   └── glass-theme.css           ← Compiled CSS (commit this)
├── js/
│   └── glass-theme.js            ← Vanilla JS (nav, toggle, reveal…)
│
├── templates/
│   └── frontend/
│       ├── components/
│       │   ├── header.tpl        ← Sticky glass nav + locale switcher
│       │   ├── footer.tpl        ← Dark glass footer
│       │   ├── breadcrumbs.tpl   ← Frosted breadcrumb bar
│       │   └── pagination.tpl    ← Glass pagination
│       └── pages/
│           ├── indexJournal.tpl  ← Home: hero + current issue + announcements
│           ├── article.tpl       ← Article detail: 2-col layout + glass sidebar
│           ├── issueArchive.tpl  ← Issue archive grid
│           └── search.tpl        ← Search hero + results
│
├── locale/
│   ├── en/locale.po              ← English strings
│   └── id/locale.po              ← Bahasa Indonesia strings
│
└── public/
    └── images/
        └── hero-bg.svg           ← Hero background (no external deps)
```

---

## Installation

### 1. Copy the plugin

```bash
cp -r my-ojs-theme /path/to/ojs/plugins/themes/glassTheme
```

> ⚠️ The folder name **must** be `glassTheme` — this must match the plugin class name.

### 2. Build the CSS (optional — pre-compiled CSS is already included)

```bash
cd plugins/themes/glassTheme
npm install
npm run build      # outputs styles/glass-theme.css
```

For live development:

```bash
npm run dev        # watches tailwind.css for changes
```

### 3. Activate in OJS

1. Log in as **Admin / Journal Manager**
2. Go to **Settings → Website → Plugins**
3. Find **Glass Theme** under *Themes* and enable it
4. Go to **Settings → Website → Appearance** and select **Glass Theme**
5. Configure options (Accent Color, Blur Intensity, Default Mode) and save

---

## Locale Support

This theme ships translations for:

| Locale Code | Language |
|-------------|----------|
| `en` / `en_US` | English (primary) |
| `id` / `id_ID` | Bahasa Indonesia |

OJS automatically loads the correct locale file based on the site/journal locale setting.  
To add more languages, copy `locale/en/locale.po`, translate the `msgstr` values, and place  
the file in `locale/<lang_code>/locale.po`.

---

## Tailwind CSS 4 Notes

Tailwind 4 uses **CSS-native configuration** — all design tokens live in `tailwind.css`:

```css
@import "tailwindcss";

@theme {
  --font-sans: "Inter", system-ui, sans-serif;
  --color-accent: var(--glass-accent, #6366f1);
  /* … */
}
```

No `tailwind.config.js` is needed. The PHP plugin dynamically injects accent color  
and blur intensity as CSS custom properties via an inline `<style>` block, which  
Tailwind's `@theme` variables then reference at runtime.

---

## Theme Options (Admin)

| Option | Values | Effect |
|--------|--------|--------|
| **Accent Color** | Indigo · Violet · Emerald · Rose | Sets `--glass-accent` CSS variable |
| **Blur Intensity** | Light (8px) · Medium (16px) · Heavy (28px) | Sets `--glass-blur` CSS variable |
| **Default Mode** | Dark · Light · Auto | Initial color scheme before user toggles |

---

## Browser Support

| Feature | Coverage |
|---------|----------|
| `backdrop-filter` | Chrome 76+, Firefox 103+, Safari 9+ |
| `IntersectionObserver` | All modern browsers |
| CSS Custom Properties | All modern browsers |

For browsers without `backdrop-filter` support, glass cards gracefully degrade  
to a semi-transparent background with a solid border.

---

## License

Distributed under the **GNU GPL v3**. See `docs/COPYING` in your OJS installation.
