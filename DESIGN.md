# Design Guidelines for HTML Pages

This document outlines the design system used across all HTML pages in this repository. Follow these guidelines when creating new pages to ensure consistency and optimal performance.

## Core Principles

1. **Lightweight CSS** - No GPU-intensive effects (avoid `backdrop-filter: blur()`, animated blur filters, or floating animated elements)
2. **CSS Variables** - Use CSS custom properties for all colors to enable easy theming
3. **Dark/Light Mode** - Support both themes using `data-theme` attribute on `<html>`
4. **Responsive Design** - Mobile-first approach with breakpoints
5. **Simple Shadows** - Use solid shadows instead of complex blur effects

## CSS Variables

All pages must define these CSS variables in `:root` and `[data-theme="dark"]`:

```css
:root {
    /* Backgrounds */
    --bg-primary: #f8fafc;      /* Main page background */
    --bg-secondary: #ffffff;    /* Cards, modals, containers */
    --bg-tertiary: #f1f5f9;     /* Input backgrounds, subtle sections */

    /* Text Colors */
    --text-primary: #1e293b;    /* Main text, headings */
    --text-secondary: #64748b;  /* Secondary text, descriptions */
    --text-muted: #94a3b8;      /* Placeholder text, hints */

    /* UI Elements */
    --border-color: #e2e8f0;    /* Borders, dividers */
    --accent-1: #6366f1;        /* Primary accent (indigo) */
    --accent-2: #8b5cf6;        /* Secondary accent (purple) */
    --success: #10b981;         /* Success states */
    --danger: #ef4444;          /* Error states, warnings */

    /* Shadows */
    --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
    --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.1);

    /* Gradient */
    --gradient-primary: linear-gradient(135deg, var(--accent-1) 0%, var(--accent-2) 100%);
}

[data-theme="dark"] {
    --bg-primary: #0f172a;
    --bg-secondary: #1e293b;
    --bg-tertiary: #334155;
    --text-primary: #f1f5f9;
    --text-secondary: #94a3b8;
    --text-muted: #64748b;
    --border-color: #334155;
    --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.3);
    --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.3);
}
```

## Typography

Use the Inter font from Google Fonts:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
```

```css
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    line-height: 1.6;
}
```

## Component Styles

### Cards / Containers

```css
.card {
    background: var(--bg-secondary);
    border-radius: 16px;
    padding: 24px;
    box-shadow: var(--shadow-md);
    border: 1px solid var(--border-color);
}
```

### Buttons

```css
/* Primary Button */
.btn-primary {
    background: var(--gradient-primary);
    color: white;
    padding: 10px 18px;
    border-radius: 10px;
    border: none;
    font-weight: 500;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-primary:hover {
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
}

/* Secondary Button */
.btn-secondary {
    background: var(--bg-tertiary);
    color: var(--text-secondary);
    border: 1px solid var(--border-color);
    padding: 10px 18px;
    border-radius: 10px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-secondary:hover {
    background: var(--border-color);
}
```

### Form Inputs

```css
input, textarea, select {
    padding: 12px 16px;
    border: 1px solid var(--border-color);
    border-radius: 10px;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    font-size: 0.95rem;
    transition: all 0.2s ease;
    font-family: inherit;
}

input:focus, textarea:focus, select:focus {
    outline: none;
    border-color: var(--accent-1);
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

input::placeholder, textarea::placeholder {
    color: var(--text-muted);
}
```

### Tags / Badges

```css
.tag {
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    background: var(--bg-tertiary);
    color: var(--accent-2);
}

.badge {
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    background: var(--gradient-primary);
    color: white;
}
```

## Theme Toggle

Include a theme toggle button and JavaScript:

```html
<button class="theme-toggle" onclick="toggleTheme()" title="Toggle theme">
    <span id="theme-icon">&#127769;</span>
</button>
```

```css
.theme-toggle {
    background: var(--bg-tertiary);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    padding: 8px 12px;
    cursor: pointer;
    font-size: 1.1rem;
    transition: all 0.2s ease;
}

.theme-toggle:hover {
    background: var(--border-color);
}
```

```javascript
function toggleTheme() {
    const html = document.documentElement;
    const isDark = html.getAttribute('data-theme') === 'dark';
    html.setAttribute('data-theme', isDark ? 'light' : 'dark');
    localStorage.setItem('theme', isDark ? 'light' : 'dark');
    document.getElementById('theme-icon').innerHTML = isDark ? '&#127769;' : '&#9728;';
}

function initTheme() {
    const saved = localStorage.getItem('theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const theme = saved || (prefersDark ? 'dark' : 'light');
    document.documentElement.setAttribute('data-theme', theme);
    document.getElementById('theme-icon').innerHTML = theme === 'dark' ? '&#9728;' : '&#127769;';
}

// Call on page load
initTheme();
```

## Responsive Breakpoints

```css
/* Mobile first - default styles for mobile */

/* Tablet and up */
@media (min-width: 768px) {
    /* Tablet styles */
}

/* Desktop and up */
@media (min-width: 1024px) {
    /* Desktop styles */
}
```

## Transitions

Keep transitions short and simple:

```css
transition: all 0.2s ease;
```

Avoid using long or complex animations that could impact performance.

## What to Avoid

1. **`backdrop-filter: blur()`** - Heavy GPU usage, causes crashes on some browsers
2. **Large animated elements** - Especially with `filter: blur()` applied
3. **Complex `@keyframes` animations** - Keep animations minimal
4. **Multiple layered shadows** - Use single, simple shadows
5. **Large gradients on animated elements** - Keep gradients on static elements only

## File Structure

Each HTML page should include:

1. **Meta tags** - charset, viewport
2. **Google Fonts link** - Inter font
3. **CSS in `<style>`** - All styles inline for single-file simplicity
4. **HTML structure** - Semantic HTML with proper accessibility
5. **JavaScript** - At bottom of body, theme initialization first

## Example Page Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Title</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* CSS Variables */
        :root { /* ... */ }
        [data-theme="dark"] { /* ... */ }

        /* Base Styles */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { /* ... */ }

        /* Components */
        /* ... */

        /* Responsive */
        @media (max-width: 768px) { /* ... */ }
    </style>
</head>
<body>
    <!-- Content -->

    <script>
        // Theme functions
        function toggleTheme() { /* ... */ }
        function initTheme() { /* ... */ }

        // Initialize
        initTheme();

        // Page-specific JavaScript
    </script>
</body>
</html>
```

## Color Reference

| Variable | Light Mode | Dark Mode | Usage |
|----------|------------|-----------|-------|
| `--bg-primary` | `#f8fafc` | `#0f172a` | Page background |
| `--bg-secondary` | `#ffffff` | `#1e293b` | Cards, modals |
| `--bg-tertiary` | `#f1f5f9` | `#334155` | Inputs, subtle areas |
| `--text-primary` | `#1e293b` | `#f1f5f9` | Main text |
| `--text-secondary` | `#64748b` | `#94a3b8` | Secondary text |
| `--text-muted` | `#94a3b8` | `#64748b` | Placeholders |
| `--border-color` | `#e2e8f0` | `#334155` | Borders |
| `--accent-1` | `#6366f1` | `#6366f1` | Primary accent |
| `--accent-2` | `#8b5cf6` | `#8b5cf6` | Secondary accent |
| `--success` | `#10b981` | `#10b981` | Success states |
| `--danger` | `#ef4444` | `#ef4444` | Error states |
