/**
 * Glass Theme — Main JavaScript
 */

(() => {
    'use strict';

    const STORAGE_THEME_KEY = 'glass-theme-color-mode';
    const $ = (sel, ctx = document) => ctx.querySelector(sel);
    const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

    // ─── 1. Theme Logic (Run ASAP) ───────────────────────────────────────────
    function initTheme() {
        const root = document.documentElement;
        
        const applyTheme = (mode) => {
            root.setAttribute('data-theme', mode);
            document.body.setAttribute('data-theme', mode);
            
            const btn = $('#theme-toggle');
            if (btn) {
                btn.innerHTML = mode === 'dark' ? '☀️' : '🌙';
            }
        };

        const getPreferred = () => {
            const stored = localStorage.getItem(STORAGE_THEME_KEY);
            if (stored) return stored;
            return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        };

        // Initial apply
        const currentMode = getPreferred();
        applyTheme(currentMode);

        // Global click listener for the toggle (more resilient than direct binding)
        document.addEventListener('click', e => {
            const btn = e.target.closest('#theme-toggle');
            if (!btn) return;
            
            const current = root.getAttribute('data-theme') || 'dark';
            const next = current === 'dark' ? 'light' : 'dark';
            
            localStorage.setItem(STORAGE_THEME_KEY, next);
            applyTheme(next);
        });
    }

    // ─── 2. Transitions ──────────────────────────────────────────────────────
    function initTransitions() {
        const body = document.body;
        body.classList.add('page-fade');
        setTimeout(() => { body.style.opacity = '1'; }, 100);

        document.addEventListener('click', e => {
            const link = e.target.closest('a[href]');
            if (!link || e.defaultPrevented) return;

            const href = link.href;
            const attrHref = link.getAttribute('href') || '';
            
            if (!href || attrHref.startsWith('#') || attrHref.startsWith('javascript') ||
                link.target === '_blank' || link.hasAttribute('download') ||
                e.metaKey || e.ctrlKey) return;

            try {
                const url = new URL(href);
                if (url.origin !== window.location.origin) return;
                if (url.pathname.includes('/download/') || url.pathname.includes('/view/')) return;
            } catch (_) { return; }

            e.preventDefault();
            body.style.transition = 'opacity 0.2s ease';
            body.style.opacity = '0';
            setTimeout(() => { window.location.href = href; }, 200);
        });
    }

    // ─── 3. Nav & Scroll ─────────────────────────────────────────────────────
    function initNav() {
        const nav = $('.glass-nav');
        if (!nav) return;

        window.addEventListener('scroll', () => {
            nav.classList.toggle('nav-scrolled', window.scrollY > 50);
        }, { passive: true });

        // Mobile menu
        const toggle = $('#nav-toggle');
        const menu = $('#mobile-menu');
        if (toggle && menu) {
            toggle.addEventListener('click', () => {
                const isOpen = menu.classList.toggle('open');
                toggle.classList.toggle('open', isOpen);
                document.body.style.overflow = isOpen ? 'hidden' : '';
            });
        }
        
        // Dropdown Locale
        const localeBtn = $('#locale-btn');
        const localeDrop = $('#locale-dropdown');
        if (localeBtn && localeDrop) {
            localeBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                localeDrop.classList.toggle('open');
            });
            document.addEventListener('click', () => localeDrop.classList.remove('open'));
        }
    }

    // ─── 4. Reveal ───────────────────────────────────────────────────────────
    function initReveal() {
        const elements = $$('.reveal');
        if (!elements.length || !('IntersectionObserver' in window)) {
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
        }, { threshold: 0.1 });

        elements.forEach(el => observer.observe(el));
        setTimeout(() => {
            $$('.reveal:not(.visible)').forEach(el => el.classList.add('visible'));
        }, 1500);
    }

    // ─── Start ───────────────────────────────────────────────────────────────
    const start = () => {
        initTheme();
        initTransitions();
        initNav();
        initReveal();
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', start);
    } else {
        start();
    }
})();
