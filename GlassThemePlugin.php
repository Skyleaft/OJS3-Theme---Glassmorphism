<?php

/**
 * @file plugins/themes/glassTheme/GlassThemePlugin.php
 *
 * Copyright (c) 2024 Your Journal
 * Distributed under the GNU GPL v3. For full terms see docs/COPYING.
 *
 * @class GlassThemePlugin
 * @brief Modern glassmorphism theme for OJS 3.5
 *
 * Features:
 *  - Blurred glass (glassmorphism) UI style
 *  - Tailwind CSS 4 compiled utilities
 *  - Smooth page transitions & micro-animations
 *  - Bilingual: English (primary) + Bahasa Indonesia
 *  - Dark/light mode toggle (persisted in localStorage)
 */

namespace APP\plugins\themes\glassTheme;

use PKP\plugins\ThemePlugin;

class GlassThemePlugin extends ThemePlugin
{
    // ─── Option Defaults ──────────────────────────────────────────────────
    const OPTION_COLOR_ACCENT   = 'accentColor';
    const OPTION_BLUR_INTENSITY = 'blurIntensity';
    const OPTION_DEFAULT_MODE   = 'defaultColorMode';

    // ─── Lifecycle ────────────────────────────────────────────────────────

    /**
     * Initialize the theme — called once when the plugin is activated.
     */
    public function init(): void
    {
        // error_log('GlassThemePlugin: init() called');
        // Inherit every template & style from the default OJS theme.
        // We only override what we explicitly need to.
        $this->setParent('defaultTheme');

        // ── Theme Options (visible in Website → Appearance) ───────────────
        $this->addOption(self::OPTION_COLOR_ACCENT, 'radio', [
            'label'   => 'plugins.themes.glassTheme.option.accentColor',
            'options' => [
                'indigo'   => 'plugins.themes.glassTheme.option.accentColor.indigo',
                'violet'   => 'plugins.themes.glassTheme.option.accentColor.violet',
                'emerald'  => 'plugins.themes.glassTheme.option.accentColor.emerald',
                'rose'     => 'plugins.themes.glassTheme.option.accentColor.rose',
            ],
        ]);

        $this->addOption(self::OPTION_BLUR_INTENSITY, 'radio', [
            'label'   => 'plugins.themes.glassTheme.option.blurIntensity',
            'options' => [
                'light'  => 'plugins.themes.glassTheme.option.blurIntensity.light',
                'medium' => 'plugins.themes.glassTheme.option.blurIntensity.medium',
                'heavy'  => 'plugins.themes.glassTheme.option.blurIntensity.heavy',
            ],
        ]);

        $this->addOption(self::OPTION_DEFAULT_MODE, 'radio', [
            'label'   => 'plugins.themes.glassTheme.option.defaultColorMode',
            'options' => [
                'dark'  => 'plugins.themes.glassTheme.option.defaultColorMode.dark',
                'light' => 'plugins.themes.glassTheme.option.defaultColorMode.light',
                'auto'  => 'plugins.themes.glassTheme.option.defaultColorMode.auto',
            ],
        ]);

        // ── Styles ────────────────────────────────────────────────────────
        // Google Fonts — Inter (variable weight 300-800)
        $this->addStyle(
            'google-fonts',
            'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap',
            ['baseUrl' => '']
        );

        // Main compiled stylesheet (Tailwind 4 output + hand-crafted glass classes)
        $this->addStyle('glass-theme', 'styles/glass-theme.css');

        // ── Dynamic CSS Variables from Options ────────────────────────────
        $this->addStyle('glass-dynamic-vars', $this->buildDynamicVars(), ['inline' => true]);

        // ── Template Data ─────────────────────────────────────────────────
        \PKP\plugins\Hook::add('TemplateManager::display', [$this, 'loadTemplateData']);
    }

    /**
     * Pass theme options to Smarty templates
     */
    public function loadTemplateData($hookName, $args)
    {
        $templateMgr = $args[0];
        $templateMgr->assign('colorMode', $this->getOption(self::OPTION_DEFAULT_MODE) ?? 'dark');
        return false;
    }



    /**
     * Build inline CSS variables based on active theme options.
     */
    protected function buildDynamicVars(): string
    {
        $accent    = $this->getOption(self::OPTION_COLOR_ACCENT)   ?? 'indigo';
        $blur      = $this->getOption(self::OPTION_BLUR_INTENSITY) ?? 'medium';
        $colorMode = $this->getOption(self::OPTION_DEFAULT_MODE)   ?? 'dark';

        $accentMap = [
            'indigo'  => ['#6366f1', '#4f46e5', '#a5b4fc'],
            'violet'  => ['#8b5cf6', '#7c3aed', '#c4b5fd'],
            'emerald' => ['#10b981', '#059669', '#6ee7b7'],
            'rose'    => ['#f43f5e', '#e11d48', '#fda4af'],
        ];

        $blurMap = [
            'light'  => '8px',
            'medium' => '16px',
            'heavy'  => '28px',
        ];

        [$base, $dark, $light] = $accentMap[$accent] ?? $accentMap['indigo'];
        $blurVal = $blurMap[$blur] ?? '16px';

        $defaultScheme = ($colorMode === 'dark') ? 'dark' : 'light';

        return "
:root {
    --glass-accent:       {$base} !important;
    --glass-accent-dark:  {$dark} !important;
    --glass-accent-light: {$light} !important;
    --glass-blur:         {$blurVal} !important;
    --glass-default-scheme: '{$defaultScheme}' !important;
}";
    }

    // ─── ThemePlugin contract ─────────────────────────────────────────────

    public function getDisplayName(): string
    {
        return __('plugins.themes.glassTheme.name');
    }

    public function getDescription(): string
    {
        return __('plugins.themes.glassTheme.description');
    }
}
