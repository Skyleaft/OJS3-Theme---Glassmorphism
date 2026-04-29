{**
 * @file templates/frontend/pages/indexJournal.tpl
 *
 * Glass Theme — Journal index (homepage)
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── Hero Section ──────────────────────────────────────────────────────── *}
    <section class="hero" aria-label="{translate key="about.aboutTheJournal"}">

        {* Decorative animated orbs *}
        <div class="hero-orb hero-orb-1" aria-hidden="true"></div>
        <div class="hero-orb hero-orb-2" aria-hidden="true"></div>

        <div class="hero-content">
            <div class="hero-text">
                <span class="section-eyebrow">
                    {if $currentJournal->getLocalizedAcronym()}
                        <span class="accent">{$currentJournal->getLocalizedAcronym()|escape}</span> —
                    {/if}
                    {translate key="plugins.themes.glassTheme.openAccess"}
                </span>

                <h1>
                    {$currentJournal->getLocalizedName()|escape}
                </h1>

                <p>
                    {if $currentJournal->getLocalizedData('description')}
                        {$currentJournal->getLocalizedData('description')|strip_tags|truncate:240:"…"}
                    {else}
                        {translate key="plugins.themes.glassTheme.hero.defaultDescription"}
                    {/if}
                </p>

                <div class="hero-actions">
                    {if $isUserLoggedIn}
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='submission'}"
                            class="glass-btn glass-btn-primary">
                            {translate key="author.submit"}
                        </a>
                    {else}
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login' source=$smarty.server.REQUEST_URI}"
                            class="glass-btn glass-btn-primary">
                            {translate key="user.login"}
                        </a>
                        <a href="{url page="user" op="register" source=$source}" class="glass-btn glass-btn-ghost">
                            {translate key="user.register"}
                        </a>
                    {/if}
                </div>
            </div>

            <div class="hero-card-container">
                <div class="glass-card hero-journal-card">
                    <div class="journal-meta">
                        <div class="journal-meta-row">
                            <span
                                class="badge badge-accent">{translate key="plugins.themes.glassTheme.peerReviewed"}</span>
                            <span class="badge badge-success">Active</span>
                        </div>

                        <div class="journal-meta-row" style="margin-top: .5rem;">
                            <strong>ISSN:</strong>
                            <span>{$currentJournal->getData('onlineIssn')|escape|default:$currentJournal->getData('printIssn')|escape}</span>
                        </div>

                        <div class="journal-meta-row">
                            <strong>{translate key="plugins.themes.glassTheme.frequency"}:</strong>
                            <span>
                                {assign var="freq" value=$currentJournal->getLocalizedData('publishingFrequency')}
                                {if $freq}{$freq|escape}{else}{translate key="plugins.themes.glassTheme.frequency.biannual"}{/if}
                            </span>
                        </div>
                    </div>

                    {if $issue}
                        <div style="margin-top: 1.5rem; padding-top: 1.25rem; border-top: 1px solid var(--glass-border);">
                            <div
                                style="font-size: .7rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .75rem;">
                                {translate key="plugins.themes.glassTheme.latestIssue"}
                            </div>
                            <h3 style="font-size: .95rem; font-weight: 600; color: var(--glass-text); line-height: 1.4;">
                                {$issue->getIssueIdentification()|escape}
                            </h3>
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='view' path=$issue->getBestIssueId()}"
                                class="glass-btn glass-btn-primary"
                                style="margin-top: 1.25rem; width: 100%; justify-content: center;">
                                {translate key="plugins.themes.glassTheme.viewIssue"}
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </section>

    {* ── Main Content Area (Announcements + Archives) + Right Sidebar ───────── *}
    <section class="index-section">
        <div class="page-container">
            <div class="index-layout">

                {* ── Left / Main Column ────────────────────────────────────── *}
                <div class="index-main">

                    {* Current Issue Featured Section *}
                    {if $issue}
                        <div class="current-issue-block" style="margin-bottom: 4rem;">
                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <span class="section-eyebrow">{translate key="plugins.themes.glassTheme.issue"}</span>
                                <h2 class="section-title">{translate key="plugins.themes.glassTheme.latestIssue"}</h2>
                            </div>

                            <div class="glass-card current-issue-featured"
                                style="display: flex; overflow: hidden; border-radius: var(--radius-glass); position: relative;">

                                {* Issue Cover *}
                                {if $issue->getLocalizedCoverImageUrl()}
                                    <div class="featured-cover-wrapper"
                                        style="flex: 0 0 280px; position: relative; overflow: hidden; border-right: 1px solid var(--glass-border);">
                                        <img src="{$issue->getLocalizedCoverImageUrl()|escape}"
                                            alt="{$issue->getIssueIdentification()|escape}"
                                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease;">
                                    </div>
                                {else}
                                    <div
                                        style="flex: 0 0 280px; background: rgba(255,255,255,0.03); display: flex; align-items: center; justify-content: center; border-right: 1px solid var(--glass-border);">
                                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                            stroke-width="1" opacity="0.2">
                                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                                        </svg>
                                    </div>
                                {/if}

                                {* Issue Details *}
                                <div
                                    style="padding: 2.5rem; flex: 1; display: flex; flex-direction: column; justify-content: center; background: linear-gradient(to right, rgba(255,255,255,0.02), transparent);">
                                    <span class="issue-vol"
                                        style="font-size: 0.75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; letter-spacing: 0.1em;">
                                        {if $issue->getVolume()}Vol. {$issue->getVolume()|escape}{/if}
                                        {if $issue->getNumber()} No. {$issue->getNumber()|escape}{/if}
                                        ({$issue->getYear()|escape})
                                    </span>

                                    <h3
                                        style="font-size: 1.75rem; margin: 0.75rem 0 1.25rem; font-weight: 800; line-height: 1.2; color: var(--glass-text);">
                                        {if $issue->getLocalizedTitle()}
                                            {$issue->getLocalizedTitle()|escape}
                                        {else}
                                            {$issue->getIssueIdentification()|escape}
                                        {/if}
                                    </h3>

                                    {if $issue->getLocalizedDescription()}
                                        <div
                                            style="font-size: 0.95rem; color: var(--glass-text-muted); line-height: 1.7; margin-bottom: 2rem; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; max-width: 600px;">
                                            {$issue->getLocalizedDescription()|strip_tags}
                                        </div>
                                    {/if}

                                    <div style="display: flex; align-items: center; gap: 1.5rem;">
                                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='view' path=$issue->getBestIssueId()}"
                                            class="glass-btn glass-btn-primary"
                                            style="padding: 1rem 2.5rem; font-size: 1rem;">
                                            {translate key="plugins.themes.glassTheme.viewIssue"}
                                        </a>
                                        {if $issue->getDatePublished()}
                                            <span style="font-size: 0.85rem; color: var(--glass-text-subtle);">
                                                {translate key="submissions.published"}:
                                                {$issue->getDatePublished()|date_format:$dateFormatShort}
                                            </span>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}


                    {* Announcements *}
                    {if $announcements && $announcements|@count}
                        <div class="announcements-block" style="margin-bottom: 4rem;">
                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <span class="section-eyebrow">{translate key="announcement.announcements"}</span>
                                <h2 class="section-title">{translate key="plugins.themes.glassTheme.latestNews"}</h2>
                            </div>

                            <div class="card-grid"
                                style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1.5rem;">
                                {foreach from=$announcements item=announcement}
                                    <div class="glass-card" style="padding: 1.5rem;">
                                        <span class="badge badge-accent" style="margin-bottom: .75rem;">
                                            {$announcement->getDatePosted()|date_format:$dateFormatShort}
                                        </span>
                                        <h3 style="font-size: 1.1rem; margin-bottom: .75rem;">
                                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='announcement' op='view' path=$announcement->getId()}"
                                                style="color: inherit; text-decoration: none;">
                                                {$announcement->getLocalizedTitle()|escape}
                                            </a>
                                        </h3>
                                        <p style="font-size: .85rem; color: var(--glass-text-muted); line-height: 1.6;">
                                            {$announcement->getLocalizedDescriptionShort()|strip_tags}
                                        </p>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}

                </div>

                {* ── Right Sidebar ──────────────────────────────────────────── *}
                <aside class="index-sidebar" aria-label="{translate key="plugins.themes.glassTheme.sidebar.label"}">

                    {* ── 1. Journal Information Block ─────────────────────── *}
                    {if $sidebarShowInfo}
                        <div class="sidebar-widget glass-card">
                            <h3 class="sidebar-widget-title">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" aria-hidden="true">
                                    <circle cx="12" cy="12" r="10" />
                                    <line x1="12" y1="8" x2="12" y2="12" />
                                    <line x1="12" y1="16" x2="12.01" y2="16" />
                                </svg>
                                {translate key="plugins.themes.glassTheme.sidebar.journalInfo"}
                            </h3>
                            <ul class="sidebar-info-list">
                                {if $currentJournal->getData('onlineIssn') || $currentJournal->getData('printIssn')}
                                    <li>
                                        <span class="sidebar-info-label">{translate key="journal.eIssn"}</span>
                                        <span class="sidebar-info-value">
                                            {$currentJournal->getData('onlineIssn')|escape|default:"—"}
                                        </span>
                                    </li>
                                    <li>
                                        <span class="sidebar-info-label">{translate key="journal.pIssn"}</span>
                                        <span class="sidebar-info-value">
                                            {$currentJournal->getData('printIssn')|escape|default:"—"}
                                        </span>
                                    </li>
                                {/if}
                                {assign var="freq" value=$currentJournal->getLocalizedData('publishingFrequency')}
                                {if $freq}
                                    <li>
                                        <span
                                            class="sidebar-info-label">{translate key="plugins.themes.glassTheme.frequency"}</span>
                                        <span class="sidebar-info-value">{$freq|escape}</span>
                                    </li>
                                {/if}
                                {if $currentJournal->getData('publisherInstitution')}
                                    <li>
                                        <span
                                            class="sidebar-info-label">{translate key="plugins.themes.glassTheme.sidebar.publisher"}</span>
                                        <span
                                            class="sidebar-info-value">{$currentJournal->getData('publisherInstitution')|escape}</span>
                                    </li>
                                {/if}
                                {if $currentJournal->getData('licenseUrl')}
                                    <li>
                                        <span
                                            class="sidebar-info-label">{translate key="plugins.themes.glassTheme.sidebar.license"}</span>
                                        <span class="sidebar-info-value">
                                            <a href="{$currentJournal->getData('licenseUrl')|escape}" target="_blank"
                                                rel="noopener" class="sidebar-link">
                                                {translate key="plugins.themes.glassTheme.sidebar.viewLicense"}
                                            </a>
                                        </span>
                                    </li>
                                {/if}
                            </ul>
                        </div>
                    {/if}

                    {* ── 2. Journal Template / Custom Link ────────────────── *}
                    {if $sidebarShowTemplate}
                        <div class="sidebar-widget glass-card">
                            <h3 class="sidebar-widget-title">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" aria-hidden="true">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                                    <polyline points="14 2 14 8 20 8" />
                                    <line x1="16" y1="13" x2="8" y2="13" />
                                    <line x1="16" y1="17" x2="8" y2="17" />
                                    <polyline points="10 9 9 9 8 9" />
                                </svg>
                                {translate key="plugins.themes.glassTheme.sidebar.journalTemplate"}
                            </h3>
                            <p class="sidebar-info-desc">
                                {translate key="plugins.themes.glassTheme.sidebar.journalTemplate.desc"}
                            </p>
                            {if $sidebarTemplateUrl}
                                <a href="{$sidebarTemplateUrl|escape}" target="_blank" rel="noopener"
                                    class="glass-btn glass-btn-primary sidebar-cta">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" aria-hidden="true">
                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
                                        <polyline points="7 10 12 15 17 10" />
                                        <line x1="12" y1="15" x2="12" y2="3" />
                                    </svg>
                                    {if $sidebarTemplateLabel}{$sidebarTemplateLabel|escape}{else}{translate key="plugins.themes.glassTheme.sidebar.downloadTemplate"}{/if}
                                </a>
                            {else}
                                <span class="sidebar-no-link">
                                    {translate key="plugins.themes.glassTheme.sidebar.templateNotSet"}
                                </span>
                            {/if}
                        </div>
                    {/if}

                    {* ── 3. Journal Visitors (Statcounter/Custom) ────────── *}
                    {if $sidebarShowVisitors}
                        <div class="sidebar-widget glass-card" id="sidebar-visitors">
                            <h3 class="sidebar-widget-title">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" aria-hidden="true">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
                                    <circle cx="9" cy="7" r="4" />
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                                </svg>
                                {translate key="plugins.themes.glassTheme.sidebar.visitors"}
                            </h3>
                            <div class="visitor-custom-content">
                                {if $sidebarVisitorCode}
                                    {$sidebarVisitorCode}
                                {else}
                                    <div class="visitor-stats">
                                        <div class="visitor-stat-item">
                                            <span class="visitor-stat-number" id="visitor-today">—</span>
                                            <span
                                                class="visitor-stat-label">{translate key="plugins.themes.glassTheme.sidebar.visitors.today"}</span>
                                        </div>
                                        <div class="visitor-stat-divider" aria-hidden="true"></div>
                                        <div class="visitor-stat-item">
                                            <span class="visitor-stat-number" id="visitor-total">—</span>
                                            <span
                                                class="visitor-stat-label">{translate key="plugins.themes.glassTheme.sidebar.visitors.total"}</span>
                                        </div>
                                    </div>
                                    <p class="sidebar-info-desc" style="margin-top: .75rem; font-size: .72rem;">
                                        {translate key="plugins.themes.glassTheme.sidebar.visitors.note"}
                                    </p>
                                {/if}
                            </div>
                        </div>
                    {/if}

                    {* ── 4. Indexed By (Icons) ────────────────────────────── *}
                    {if $sidebarShowIndexed}
                        <div class="sidebar-widget glass-card">
                            <h3 class="sidebar-widget-title">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" aria-hidden="true">
                                    <polyline points="22 12 18 12 15 21 9 3 6 12 2 12" />
                                </svg>
                                {translate key="plugins.themes.glassTheme.sidebar.indexedBy"}
                            </h3>
                            {if $sidebarIndexedList && $sidebarIndexedList|@count}
                                <div class="indexed-icons-grid">
                                    {foreach from=$sidebarIndexedList item=index}
                                        {if $index.link}<a href="{$index.link|escape}" target="_blank" rel="noopener"
                                            class="indexed-icon-link">{/if}
                                            {if $index.image}
                                                <img src="{$index.image|escape}" alt="{$index.name|escape}" title="{$index.name|escape}"
                                                    class="indexed-logo" />
                                            {else}
                                                <span class="indexed-fallback">{$index.name|escape}</span>
                                            {/if}
                                            {if $index.link}</a>{/if}
                                    {/foreach}
                                </div>
                            {else}
                                <p class="sidebar-info-desc">
                                    {translate key="plugins.themes.glassTheme.sidebar.indexedBy.notSet"}
                                </p>
                            {/if}
                        </div>
                    {/if}

                </aside>
            </div>{* /.index-layout *}
        </div>{* /.page-container *}
    </section>

</main>

{* ── Local Visitor counter script (only if no third party code) ────────────── *}
{if $sidebarShowVisitors && !$sidebarVisitorCode}
    <script>
        (function() {
            'use strict';
            var KEY_TOTAL = 'glass_visitors_total';
            var KEY_DATE = 'glass_visitors_date';
            var KEY_TODAY = 'glass_visitors_today';
            var today = new Date().toISOString().slice(0, 10);
            var stored = localStorage.getItem(KEY_DATE);
            var total = parseInt(localStorage.getItem(KEY_TOTAL) || '0', 10);
            var todayCount = parseInt(localStorage.getItem(KEY_TODAY) || '0', 10);

            if (stored !== today) {
                todayCount = 0;
                localStorage.setItem(KEY_DATE, today);
            }

            total++;
            todayCount++;
            localStorage.setItem(KEY_TOTAL, total);
            localStorage.setItem(KEY_TODAY, todayCount);

            function fmt(n) {
                return n.toLocaleString();
            }

            document.addEventListener('DOMContentLoaded', function() {
                var elToday = document.getElementById('visitor-today');
                var elTotal = document.getElementById('visitor-total');
                if (elToday) elToday.textContent = fmt(todayCount);
                if (elTotal) elTotal.textContent = fmt(total);
            });
        }());
    </script>
{/if}

{include file="frontend/components/footer.tpl"}