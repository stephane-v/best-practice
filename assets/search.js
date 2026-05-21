/* Client-side search over search-index.json using Fuse.js (loaded from CDN).
   Exposes window.BPSearch.attach(inputEl, resultsEl, base). */
(function () {
  'use strict';

  var BASE = window.BP_BASE || '';
  var FUSE_URL = 'https://cdn.jsdelivr.net/npm/fuse.js@7.0.0/dist/fuse.min.js';
  var fuse = null;

  function loadFuse() {
    return new Promise(function (resolve, reject) {
      if (window.Fuse) return resolve();
      var s = document.createElement('script');
      s.src = FUSE_URL;
      s.onload = resolve;
      s.onerror = reject;
      document.head.appendChild(s);
    });
  }

  function escapeHtml(s) {
    return String(s).replace(/[&<>"]/g, function (c) {
      return ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c];
    });
  }

  function build() {
    return Promise.all([
      loadFuse(),
      fetch(BASE + 'assets/search-index.json').then(function (r) {
        return r.ok ? r.json() : [];
      })
    ]).then(function (res) {
      var docs = res[1] || [];
      fuse = new window.Fuse(docs, {
        keys: [
          { name: 'title', weight: 0.6 },
          { name: 'tags', weight: 0.25 },
          { name: 'description', weight: 0.15 }
        ],
        threshold: 0.4,
        ignoreLocation: true,
        minMatchCharLength: 2
      });
    }).catch(function () { fuse = null; });
  }

  function render(results, box, base) {
    if (!results.length) {
      var msg = (window.BPI18n && window.BPI18n.ready)
        ? window.BPI18n.t('search.empty') : 'No results found';
      box.innerHTML = '<div class="bp-r-empty">' + escapeHtml(msg) + '</div>';
      box.classList.add('open');
      return;
    }
    box.innerHTML = results.slice(0, 8).map(function (r) {
      var d = r.item;
      return '<a href="' + base + escapeHtml(d.url) + '">' +
        '<div class="bp-r-title">' + escapeHtml(d.title) + '</div>' +
        '<div class="bp-r-desc">' + escapeHtml(d.description || '') + '</div>' +
        '</a>';
    }).join('');
    box.classList.add('open');
  }

  var api = {
    attach: function (input, box, base) {
      base = base || '';
      function run() {
        var q = input.value.trim();
        if (q.length < 2) {
          box.classList.remove('open');
          box.innerHTML = '';
          return;
        }
        if (!fuse) return;
        render(fuse.search(q), box, base);
      }
      input.addEventListener('input', run);
      input.addEventListener('focus', run);
      document.addEventListener('click', function (e) {
        if (e.target !== input && !box.contains(e.target)) {
          box.classList.remove('open');
        }
      });
      input.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') box.classList.remove('open');
      });
    }
  };

  window.BPSearch = api;

  build().then(function () {
    window.dispatchEvent(new Event('bp:search-ready'));
  });
})();
