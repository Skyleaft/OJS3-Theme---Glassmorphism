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

                    {if $currentIssue}
                        <div style="margin-top: 1.5rem; padding-top: 1.25rem; border-top: 1px solid var(--glass-border);">
                            <div
                                style="font-size: .7rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .75rem;">
                                {translate key="plugins.themes.glassTheme.latestIssue"}
                            </div>
                            <h3 style="font-size: .95rem; font-weight: 600; color: var(--glass-text); line-height: 1.4;">
                                {$currentIssue->getIssueIdentification()|escape}
                            </h3>
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='view' path=$currentIssue->getBestIssueId()}"
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

    {* ── Recent Articles ───────────────────────────────────────────────────── *}
    {if $announcements && $announcements|@count}
        <section class="section" style="background: rgba(255,255,255,0.02);">
            <div class="page-container">
                <div class="section-header">
                    <span class="section-eyebrow">{translate key="announcement.announcements"}</span>
                    <h2 class="section-title">{translate key="plugins.themes.glassTheme.latestNews"}</h2>
                </div>

                <div class="card-grid">
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
        </section>
    {/if}

    {* Recent Articles or Features *}
    <section class="section">
        <div class="page-container">
            <div class="section-header">
                <span class="section-eyebrow">{translate key="navigation.archives"}</span>
                <h2 class="section-title">{translate key="plugins.themes.glassTheme.browseContent"}</h2>
                <p class="section-subtitle">{translate key="plugins.themes.glassTheme.archiveSubtitle"}</p>
            </div>

            <div style="text-align: center; margin-top: 2rem;">
                <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='archive'}"
                    class="glass-btn glass-btn-primary" style="padding: 1rem 2.5rem; font-size: 1rem;">
                    {translate key="plugins.themes.glassTheme.viewAllArticles"}
                </a>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}