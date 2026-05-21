/* Global site footer as a light-DOM Web Component: <bp-footer>.
   Attribute: base="../" path prefix to repo root (default ""). */
(function () {
  'use strict';

  var CSS = `
    bp-footer { display: block; }
    .bp-ft {
      border-top: 1px solid var(--border-color);
      background: var(--bg-secondary);
      margin-top: 40px;
    }
    .bp-ft-inner {
      max-width: 1200px; margin: 0 auto;
      padding: 24px 20px;
      display: flex; align-items: center; justify-content: center;
      flex-wrap: wrap; gap: 14px;
      font-size: 0.85rem; color: var(--text-muted);
    }
    .bp-ft-inner a {
      color: var(--accent-1); text-decoration: none; font-weight: 500;
    }
    .bp-ft-inner a:hover { text-decoration: underline; }
    .bp-ft-sep { color: var(--border-color); }
    .bp-ft-lang {
      background: var(--bg-tertiary); border: 1px solid var(--border-color);
      border-radius: 8px; padding: 5px 10px; cursor: pointer;
      font-size: 0.78rem; font-weight: 600; color: var(--text-secondary);
      font-family: inherit; transition: all 0.2s ease;
    }
    .bp-ft-lang:hover { background: var(--border-color); color: var(--text-primary); }
    @media (max-width: 600px) {
      .bp-ft-inner { flex-direction: column; gap: 10px; }
    }
  `;

  if (!document.getElementById('bp-footer-style')) {
    var st = document.createElement('style');
    st.id = 'bp-footer-style';
    st.textContent = CSS;
    document.head.appendChild(st);
  }

  function BpFooter() { return Reflect.construct(HTMLElement, [], BpFooter); }
  BpFooter.prototype = Object.create(HTMLElement.prototype);
  BpFooter.prototype.constructor = BpFooter;

  BpFooter.prototype.connectedCallback = function () {
    var year = new Date().getFullYear();
    var lang = (window.BPI18n && window.BPI18n.lang) || 'fr';
    var self = this;

    this.innerHTML =
      '<div class="bp-ft">' +
        '<div class="bp-ft-inner">' +
          '<span>© ' + year + ' Stephane Vellement</span>' +
          '<span class="bp-ft-sep">|</span>' +
          '<a href="https://github.com/stephane-v/best-practice" ' +
            'target="_blank" rel="noopener">GitHub</a>' +
          '<span class="bp-ft-sep">|</span>' +
          '<button class="bp-ft-lang" type="button" aria-label="Language">' +
            (lang === 'fr' ? 'EN' : 'FR') + '</button>' +
        '</div>' +
      '</div>';

    this.querySelector('.bp-ft-lang').addEventListener('click', function () {
      var cur = (window.BPI18n && window.BPI18n.lang) || 'fr';
      var next = cur === 'fr' ? 'en' : 'fr';
      if (window.BPI18n) window.BPI18n.setLang(next);
    });

    window.addEventListener('langchange', function (e) {
      var l = (e.detail && e.detail.lang) || 'fr';
      var btn = self.querySelector('.bp-ft-lang');
      if (btn) btn.textContent = l === 'fr' ? 'EN' : 'FR';
    });

    if (window.BPI18n && window.BPI18n.ready) window.BPI18n.apply(this);
  };

  if (!customElements.get('bp-footer')) {
    customElements.define('bp-footer', BpFooter);
  }
})();
