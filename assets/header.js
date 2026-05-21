/* Global site header as a light-DOM Web Component: <bp-header>.
   Attributes:
     base="../"        path prefix to repo root (default "")
     variant="slim"    compact bar for interactive tools (default full)
     current="tools"   active nav id, also drives the breadcrumb
   Works on GitHub Pages and from a local server, no build step. */
(function () {
  'use strict';

  var CSS = `
    bp-header { display: block; }
    .bp-hd {
      position: sticky; top: 0; z-index: 200;
      background: var(--bg-secondary);
      border-bottom: 1px solid var(--border-color);
      box-shadow: var(--card-shadow, 0 1px 3px rgba(0,0,0,0.1));
    }
    .bp-hd-inner {
      max-width: 1200px; margin: 0 auto;
      display: flex; align-items: center; gap: 14px;
      padding: 12px 20px; flex-wrap: wrap;
    }
    .bp-hd--slim .bp-hd-inner { padding: 8px 16px; gap: 10px; }
    .bp-brand {
      display: inline-flex; align-items: center; gap: 8px;
      font-weight: 700; font-size: 1.05rem; text-decoration: none;
      white-space: nowrap;
      background: var(--gradient-primary);
      -webkit-background-clip: text; background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .bp-hd--slim .bp-brand { font-size: 0.95rem; }
    .bp-brand .bp-logo {
      width: 22px; height: 22px; border-radius: 6px;
      background: var(--gradient-primary);
      -webkit-text-fill-color: white; color: white;
      display: inline-flex; align-items: center; justify-content: center;
      font-size: 0.8rem; font-weight: 700;
    }
    .bp-nav { display: flex; align-items: center; gap: 2px; flex-wrap: wrap; }
    .bp-nav a {
      color: var(--text-secondary); text-decoration: none;
      font-size: 0.9rem; font-weight: 500;
      padding: 6px 10px; border-radius: 8px;
      transition: all 0.2s ease;
    }
    .bp-nav a:hover { background: var(--bg-tertiary); color: var(--text-primary); }
    .bp-nav a.active { color: var(--accent-1); background: var(--bg-tertiary); }
    .bp-hd-spacer { flex: 1 1 16px; }
    .bp-search { position: relative; }
    .bp-search-input {
      width: 210px; padding: 8px 12px;
      border: 1px solid var(--border-color); border-radius: 10px;
      background: var(--bg-tertiary); color: var(--text-primary);
      font-size: 0.85rem; font-family: inherit;
    }
    .bp-search-input:focus {
      outline: none; border-color: var(--accent-1);
      box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
    }
    .bp-results {
      position: absolute; top: calc(100% + 6px); right: 0;
      width: 340px; max-height: 400px; overflow-y: auto;
      background: var(--bg-secondary);
      border: 1px solid var(--border-color); border-radius: 12px;
      box-shadow: var(--card-shadow-hover, 0 10px 25px rgba(0,0,0,0.15));
      padding: 6px; display: none;
    }
    .bp-results.open { display: block; }
    .bp-results a {
      display: block; padding: 10px 12px; border-radius: 8px;
      text-decoration: none; color: var(--text-primary);
    }
    .bp-results a:hover { background: var(--bg-tertiary); }
    .bp-r-title { font-size: 0.85rem; font-weight: 600; }
    .bp-r-desc {
      font-size: 0.75rem; color: var(--text-muted); margin-top: 2px;
      overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
    }
    .bp-r-empty {
      padding: 14px; font-size: 0.8rem;
      color: var(--text-muted); text-align: center;
    }
    .bp-ctl {
      background: var(--bg-tertiary); border: 1px solid var(--border-color);
      border-radius: 8px; padding: 7px 11px; cursor: pointer;
      font-size: 0.8rem; font-weight: 600; color: var(--text-secondary);
      transition: all 0.2s ease; font-family: inherit; line-height: 1;
    }
    .bp-ctl:hover { background: var(--border-color); color: var(--text-primary); }
    .bp-crumb {
      max-width: 1200px; margin: 0 auto;
      padding: 8px 20px; font-size: 0.8rem; color: var(--text-muted);
      border-top: 1px solid var(--border-color);
    }
    .bp-crumb a { color: var(--text-secondary); text-decoration: none; }
    .bp-crumb a:hover { text-decoration: underline; }
    @media (max-width: 600px) {
      .bp-search-input { width: 140px; }
      .bp-results { width: 260px; }
    }
  `;

  if (!document.getElementById('bp-header-style')) {
    var st = document.createElement('style');
    st.id = 'bp-header-style';
    st.textContent = CSS;
    document.head.appendChild(st);
  }

  var NAV = [
    { id: 'home',   key: 'nav.home',   href: 'index.html',        label: 'Home' },
    { id: 'guides', key: 'nav.guides', href: 'index.html#guides', label: 'Guides' },
    { id: 'tools',  key: 'nav.tools',  href: 'index.html#tools',  label: 'Tools' },
    { id: 'stack',  key: 'nav.stack',  href: 'stack.html',        label: 'Stack' },
    { id: 'about',  key: 'nav.about',  href: 'stack.html#about',  label: 'About' }
  ];

  var CRUMB = {
    guides: 'nav.guides',
    tools:  'nav.tools',
    stack:  'nav.stack',
    reader: 'crumb.document'
  };

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    try { localStorage.setItem('theme', theme); } catch (e) {}
  }

  function BpHeader() { return Reflect.construct(HTMLElement, [], BpHeader); }
  BpHeader.prototype = Object.create(HTMLElement.prototype);
  BpHeader.prototype.constructor = BpHeader;

  BpHeader.prototype.connectedCallback = function () {
    var base = this.getAttribute('base') || '';
    var slim = (this.getAttribute('variant') || 'full') === 'slim';
    var current = this.getAttribute('current') || '';
    var self = this;

    var navHtml = NAV.map(function (n) {
      var cls = n.id === current ? ' class="active"' : '';
      return '<a' + cls + ' href="' + base + n.href +
        '" data-i18n="' + n.key + '">' + n.label + '</a>';
    }).join('');

    var searchHtml = slim ? '' :
      '<div class="bp-search">' +
        '<input type="search" class="bp-search-input" placeholder="Search resources" ' +
        'data-i18n-placeholder="search.placeholder" aria-label="Search">' +
        '<div class="bp-results" role="listbox"></div>' +
      '</div>';

    var theme = document.documentElement.getAttribute('data-theme') || 'light';
    var lang = (window.BPI18n && window.BPI18n.lang) || 'en';

    var crumbHtml = '';
    if (current && current !== 'home' && CRUMB[current]) {
      crumbHtml = '<div class="bp-crumb"><a href="' + base + 'index.html" ' +
        'data-i18n="nav.home">Home</a> / <span data-i18n="' + CRUMB[current] +
        '">' + current + '</span></div>';
    }

    this.innerHTML =
      '<div class="bp-hd' + (slim ? ' bp-hd--slim' : '') + '">' +
        '<div class="bp-hd-inner">' +
          '<a class="bp-brand" href="' + base + 'index.html">' +
            '<span class="bp-logo">BP</span> Best Practice</a>' +
          '<nav class="bp-nav">' + navHtml + '</nav>' +
          '<div class="bp-hd-spacer"></div>' +
          searchHtml +
          '<button class="bp-ctl bp-lang" type="button" aria-label="Language">' +
            (lang === 'fr' ? 'EN' : 'FR') + '</button>' +
          '<button class="bp-ctl bp-theme" type="button" aria-label="Toggle theme">' +
            (theme === 'dark' ? '☀' : '☾') + '</button>' +
        '</div>' + crumbHtml +
      '</div>';

    this.querySelector('.bp-theme').addEventListener('click', function () {
      var cur = document.documentElement.getAttribute('data-theme') || 'light';
      var next = cur === 'dark' ? 'light' : 'dark';
      applyTheme(next);
      this.textContent = next === 'dark' ? '☀' : '☾';
    });

    this.querySelector('.bp-lang').addEventListener('click', function () {
      var cur = (window.BPI18n && window.BPI18n.lang) || 'en';
      var next = cur === 'fr' ? 'en' : 'fr';
      if (window.BPI18n) window.BPI18n.setLang(next);
    });

    window.addEventListener('langchange', function (e) {
      var l = (e.detail && e.detail.lang) || 'en';
      var btn = self.querySelector('.bp-lang');
      if (btn) btn.textContent = l === 'fr' ? 'EN' : 'FR';
    });

    if (window.BPI18n && window.BPI18n.ready) window.BPI18n.apply(this);

    var input = this.querySelector('.bp-search-input');
    var results = this.querySelector('.bp-results');
    if (input && results) {
      if (window.BPSearch) {
        window.BPSearch.attach(input, results, base);
      } else {
        window.addEventListener('bp:search-ready', function () {
          window.BPSearch.attach(input, results, base);
        });
      }
    }
  };

  if (!customElements.get('bp-header')) {
    customElements.define('bp-header', BpHeader);
  }
})();
