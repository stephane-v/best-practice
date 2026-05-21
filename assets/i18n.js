/* Lightweight i18n for the static site.
   Loads i18n/<lang>.json, applies translations to:
     [data-i18n]            -> textContent
     [data-i18n-html]       -> innerHTML
     [data-i18n-attr]       -> "attr:key" pairs, separated by ";"
   Exposes window.BPI18n, window.__I18N__, window.t and window.applyTranslations.
   Fires a "langchange" event on switch. Default language fallback is French. */
(function () {
  'use strict';

  var BASE = window.BP_BASE || '';
  var STORE = 'bp-lang';
  var cache = {};

  function detect() {
    try {
      var saved = localStorage.getItem(STORE);
      if (saved === 'fr' || saved === 'en') return saved;
    } catch (e) {}
    var nav = (navigator.language || '').toLowerCase();
    return nav.indexOf('en') === 0 ? 'en' : 'fr';
  }

  function applyTo(root, dict) {
    root = root || document;
    if (!dict) return;
    root.querySelectorAll('[data-i18n]').forEach(function (el) {
      var k = el.getAttribute('data-i18n');
      if (dict[k] != null) el.textContent = dict[k];
    });
    root.querySelectorAll('[data-i18n-html]').forEach(function (el) {
      var k = el.getAttribute('data-i18n-html');
      if (dict[k] != null) el.innerHTML = dict[k];
    });
    root.querySelectorAll('[data-i18n-attr]').forEach(function (el) {
      el.getAttribute('data-i18n-attr').split(';').forEach(function (pair) {
        var bits = pair.split(':');
        if (bits.length === 2) {
          var attr = bits[0].trim();
          var key = bits[1].trim();
          if (dict[key] != null) el.setAttribute(attr, dict[key]);
        }
      });
    });
  }

  var api = {
    lang: detect(),
    dict: {},
    ready: false,

    t: function (key, fallback) {
      var d = this.dict || {};
      return d[key] != null ? d[key] : (fallback != null ? fallback : key);
    },

    apply: function (root) {
      applyTo(root, this.dict);
    },

    load: function (lang) {
      if (cache[lang]) return Promise.resolve(cache[lang]);
      return fetch(BASE + 'i18n/' + lang + '.json')
        .then(function (r) { return r.ok ? r.json() : {}; })
        .then(function (j) { cache[lang] = j; return j; })
        .catch(function () { return {}; });
    },

    setLang: function (lang) {
      var self = this;
      this.lang = lang;
      try { localStorage.setItem(STORE, lang); } catch (e) {}
      document.documentElement.setAttribute('lang', lang);
      return this.load(lang).then(function (j) {
        self.dict = j;
        self.ready = true;
        window.__I18N__ = j;
        self.apply(document);
        window.dispatchEvent(new CustomEvent('langchange', { detail: { lang: lang } }));
      });
    }
  };

  window.BPI18n = api;
  window.__I18N__ = {};
  window.t = function (key, fallback) { return api.t(key, fallback); };
  window.applyTranslations = function (root) { api.apply(root); };

  function init() {
    api.load(api.lang).then(function (j) {
      api.dict = j;
      api.ready = true;
      window.__I18N__ = j;
      document.documentElement.setAttribute('lang', api.lang);
      api.apply(document);
      window.dispatchEvent(new CustomEvent('langchange', { detail: { lang: api.lang } }));
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
