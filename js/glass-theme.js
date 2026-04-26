/**
 * Glass Theme — Main JavaScript
 */

(() => {
    'use strict';
    console.log('Glass Theme: JS loaded and running');

    const STORAGE_THEME_KEY = 'glass-theme-color-mode';
    const $ = (sel, ctx = document) => ctx.querySelector(sel);
    const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

    // ─── 1. Theme Logic ─────────────────────────────────────────────────────
    function initTheme() {
        const root = document.documentElement;
        const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
        
        const applyTheme = (mode) => {
            root.setAttribute('data-theme', mode);
            document.body.setAttribute('data-theme', mode);
            
            if (mode === 'light') {
                root.classList.add('theme-light');
                document.body.classList.add('theme-light');
            } else {
                root.classList.remove('theme-light');
                document.body.classList.remove('theme-light');
            }
            
            // Update all toggle buttons (if there are multiple, e.g. mobile/desktop)
            $$('.theme-toggle').forEach(btn => {
                btn.innerHTML = mode === 'dark' ? '☀️' : '🌙';
            });
        };

        // Listen for system changes (only if no manual override is stored)
        mediaQuery.addEventListener('change', () => {
            if (!localStorage.getItem(STORAGE_THEME_KEY)) {
                applyTheme(mediaQuery.matches ? 'dark' : 'light');
            }
        });

        // Delegate toggle clicks
        document.addEventListener('click', e => {
            const btn = e.target.closest('.theme-toggle');
            if (!btn) return;
            
            e.preventDefault();
            const current = root.getAttribute('data-theme') || 'dark';
            const next = current === 'dark' ? 'light' : 'dark';
            
            localStorage.setItem(STORAGE_THEME_KEY, next);
            applyTheme(next);
        });

        // Final sync of icon and state
        const currentMode = root.getAttribute('data-theme') || (mediaQuery.matches ? 'dark' : 'light');
        applyTheme(currentMode);
    }

    // ─── 2. Transitions ──────────────────────────────────────────────────────
    function initTransitions() {
        const body = document.body;
        body.classList.add('page-fade');
        // The browser handles the actual navigation. 
        // Fade-in is handled by the 'page-fade' CSS class.
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

        // User Dropdown
        const userBtn = $('#user-btn');
        const userDrop = $('#user-dropdown');
        console.log('User Menu Check:', { userBtn, userDrop });
        if (userBtn && userDrop) {
            console.log('User Menu initialized');
            userBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                const isOpen = userDrop.classList.toggle('open');
                userBtn.setAttribute('aria-expanded', isOpen);
                // Close locale if open
                if (localeDrop) localeDrop.classList.remove('open');
            });
            document.addEventListener('click', () => {
                userDrop.classList.remove('open');
                userBtn.setAttribute('aria-expanded', 'false');
            });
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
