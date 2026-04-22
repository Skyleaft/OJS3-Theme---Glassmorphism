/**
 * Glass Theme — Main JavaScript
 * Handles: nav scroll, mobile menu, locale dropdown,
 *          dark/light mode toggle, scroll-reveal, page transitions.
 *
 * Vanilla ES2020 — no bundler required.
 */

(() => {
    'use strict';

    // ─── Constants ──────────────────────────────────────────────────────────
    const STORAGE_THEME_KEY = 'glass-theme-color-mode';
    const STORAGE_LANG_KEY  = 'glass-theme-locale';
    const SCROLL_THRESHOLD  = 60;

    // ─── DOM Helpers ─────────────────────────────────────────────────────────
    const $  = (sel, ctx = document) => ctx.querySelector(sel);
    const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

    // ─── 1. Page Fade-in Transition ──────────────────────────────────────────
    function initPageTransition() {
        const body = document.body;
        body.classList.add('page-fade');

        // Intercept internal link clicks for smooth exit transition
        $$('a[href]').forEach(link => {
            const href = link.getAttribute('href');
            if (!href || href.startsWith('#') || href.startsWith('javascript') ||
                href.startsWith('mailto:') || href.startsWith('tel:') ||
                link.target === '_blank') return;

            // Only intercept same-origin links
            try {
                const url = new URL(href, window.location.origin);
                if (url.origin !== window.location.origin) return;
            } catch (_) { return; }

            link.addEventListener('click', e => {
                // Allow modifier keys (open in new tab etc.)
                if (e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;
                e.preventDefault();
                body.style.transition = 'opacity 0.25s ease';
                body.style.opacity    = '0';
                setTimeout(() => { window.location.href = href; }, 260);
            });
        });
    }

    // ─── 2. Sticky Navigation ────────────────────────────────────────────────
    function initNav() {
        const nav = $('.glass-nav, .site-nav');
        if (!nav) return;

        let lastY = window.scrollY;

        const onScroll = () => {
            const y = window.scrollY;
            if (y > SCROLL_THRESHOLD) {
                nav.classList.add('nav-scrolled');
            } else {
                nav.classList.remove('nav-scrolled');
            }
            // Hide nav on fast downward scroll, reveal on upward scroll
            if (y > lastY + 6 && y > 200) {
                nav.style.transform = 'translateY(-100%)';
            } else if (y < lastY - 4) {
                nav.style.transform = 'translateY(0)';
            }
            lastY = y;
        };

        window.addEventListener('scroll', onScroll, { passive: true });

        // Mark active nav link
        const currentPath = window.location.pathname;
        $$('.nav-link').forEach(link => {
            const href = link.getAttribute('href');
            if (href && currentPath.startsWith(href) && href !== '/') {
                link.classList.add('active');
            }
        });
    }

    // ─── 3. Mobile Menu Toggle ───────────────────────────────────────────────
    function initMobileMenu() {
        const toggleBtn  = $('#nav-toggle');
        const mobileMenu = $('#mobile-menu');
        if (!toggleBtn || !mobileMenu) return;

        let open = false;

        const setOpen = (state) => {
            open = state;
            toggleBtn.classList.toggle('open', open);
            mobileMenu.classList.toggle('open', open);
            toggleBtn.setAttribute('aria-expanded', String(open));
            document.body.style.overflow = open ? 'hidden' : '';
        };

        toggleBtn.addEventListener('click', () => setOpen(!open));

        // Close on outside click
        document.addEventListener('click', e => {
            if (open && !mobileMenu.contains(e.target) && !toggleBtn.contains(e.target)) {
                setOpen(false);
            }
        });

        // Close on ESC
        document.addEventListener('keydown', e => {
            if (open && e.key === 'Escape') setOpen(false);
        });

        // Close on link click inside mobile menu
        $$('a', mobileMenu).forEach(a => a.addEventListener('click', () => setOpen(false)));
    }

    // ─── 4. Locale Switcher Dropdown ─────────────────────────────────────────
    function initLocaleSwitcher() {
        const btn      = $('#locale-btn');
        const dropdown = $('#locale-dropdown');
        if (!btn || !dropdown) return;

        let open = false;

        const setOpen = (state) => {
            open = state;
            dropdown.classList.toggle('open', open);
            btn.setAttribute('aria-expanded', String(open));
        };

        btn.addEventListener('click', e => {
            e.stopPropagation();
            setOpen(!open);
        });

        document.addEventListener('click', e => {
            if (open && !dropdown.contains(e.target) && !btn.contains(e.target)) {
                setOpen(false);
            }
        });

        document.addEventListener('keydown', e => {
            if (open && e.key === 'Escape') setOpen(false);
        });

        // Highlight current locale
        const currentLang = document.documentElement.lang || 'en';
        $$('.locale-option', dropdown).forEach(opt => {
            if (opt.dataset.locale === currentLang) {
                opt.classList.add('current');
            }
        });
    }

    // ─── 5. Dark / Light Mode Toggle ─────────────────────────────────────────
    function initThemeToggle() {
        const toggleBtn = $('#theme-toggle');
        const root      = document.documentElement;

        // Read default from PHP-generated CSS variable or localStorage
        const phpDefault = getComputedStyle(root)
            .getPropertyValue('--glass-default-scheme')
            .trim()
            .replace(/'/g, '') || 'dark';

        const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

        const getPreferred = () => {
            const stored = localStorage.getItem(STORAGE_THEME_KEY);
            if (stored) return stored;
            if (phpDefault === 'auto') return systemDark ? 'dark' : 'light';
            return phpDefault;
        };

        const applyTheme = (mode) => {
            root.dataset.theme = mode;
            if (toggleBtn) {
                toggleBtn.textContent = mode === 'dark' ? '☀️' : '🌙';
                toggleBtn.setAttribute('aria-label',
                    mode === 'dark' ? 'Switch to light mode' : 'Switch to dark mode');
            }
        };

        // Apply on load
        applyTheme(getPreferred());

        if (toggleBtn) {
            toggleBtn.addEventListener('click', () => {
                const current = root.dataset.theme || 'dark';
                const next    = current === 'dark' ? 'light' : 'dark';
                localStorage.setItem(STORAGE_THEME_KEY, next);
                applyTheme(next);
            });
        }

        // Respond to OS preference changes
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
            if (!localStorage.getItem(STORAGE_THEME_KEY) && phpDefault === 'auto') {
                applyTheme(e.matches ? 'dark' : 'light');
            }
        });
    }

    // ─── 6. Scroll-reveal (IntersectionObserver) ─────────────────────────────
    function initScrollReveal() {
        const elements = $$('.reveal');
        if (!elements.length) return;

        if (!('IntersectionObserver' in window)) {
            // Fallback: just show everything
            elements.forEach(el => el.classList.add('visible'));
            return;
        }

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

        elements.forEach(el => observer.observe(el));
    }

    // ─── 7. Smooth Search Focus ──────────────────────────────────────────────
    function initSearch() {
        const searchInput = $('#search-input, input[name="query"]');
        if (!searchInput) return;

        // Auto-focus search on '/' keypress
        document.addEventListener('keydown', e => {
            if (e.key === '/' && document.activeElement !== searchInput) {
                e.preventDefault();
                searchInput.focus();
                searchInput.select();
            }
        });
    }

    // ─── 8. Keyboard Accessibility ───────────────────────────────────────────
    function initA11y() {
        // Skip-to-content
        const skipLink = $('#skip-to-content');
        if (skipLink) {
            skipLink.addEventListener('click', (e) => {
                e.preventDefault();
                const main = $('main, #main-content');
                if (main) {
                    main.tabIndex = -1;
                    main.focus();
                }
            });
        }

        // Trap focus inside mobile menu when open
        const mobileMenu = $('#mobile-menu');
        if (mobileMenu) {
            mobileMenu.addEventListener('keydown', e => {
                if (!mobileMenu.classList.contains('open')) return;
                const focusable = $$('a, button, input, [tabindex]:not([tabindex="-1"])', mobileMenu);
                if (!focusable.length) return;
                const first = focusable[0];
                const last  = focusable[focusable.length - 1];
                if (e.key === 'Tab') {
                    if (e.shiftKey && document.activeElement === first) {
                        e.preventDefault();
                        last.focus();
                    } else if (!e.shiftKey && document.activeElement === last) {
                        e.preventDefault();
                        first.focus();
                    }
                }
            });
        }
    }

    // ─── Init ────────────────────────────────────────────────────────────────
    function init() {
        initThemeToggle();   // First — apply theme before paint
        initPageTransition();
        initNav();
        initMobileMenu();
        initLocaleSwitcher();
        initScrollReveal();
        initSearch();
        initA11y();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
