{**
 * @file templates/frontend/pages/indexJournal.tpl
 *
 * Glass Theme — Journal home page
 * Sections: Hero, Current Issue, Recent Articles
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── Hero ─────────────────────────────────────────────────────────────── *}
    <section class="hero" aria-labelledby="hero-heading">
        <div class="hero-bg" aria-hidden="true">
            <img src="{$baseUrl}/plugins/themes/glassTheme/public/images/hero-bg.svg"
                 alt="" loading="lazy">
        </div>
        <div class="hero-orb hero-orb-1" aria-hidden="true"></div>
        <div class="hero-orb hero-orb-2" aria-hidden="true"></div>

        <div class="hero-content">
            <div class="hero-text">
                <div class="badge badge-accent" style="margin-bottom:1.25rem;">
                    {translate key="plugins.themes.glassTheme.openAccess"}
                </div>

                <h1 id="hero-heading">
                    {$currentJournal->getLocalizedName()|escape}
                    {if $currentJournal->getData('acronym')}
                        <span class="accent"> ({$currentJournal->getData('acronym')|escape})</span>
                    {/if}
                </h1>

                <p>
                    {if $currentJournal->getLocalizedDescription()}
                        {$currentJournal->getLocalizedDescription()|strip_tags|truncate:220:"…"|escape}
                    {else}
                        {translate key="plugins.themes.glassTheme.hero.defaultDescription"}
                    {/if}
                </p>

                <div class="hero-actions">
                    <a class="glass-btn glass-btn-primary"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='current'}">
                        {translate key="plugins.themes.glassTheme.hero.currentIssue"}
                        <svg width="14" height="14" viewBox="0 0 14 14" fill="none" aria-hidden="true">
                            <path d="M1 7h12M7 1l6 6-6 6" stroke="currentColor" stroke-width="1.6"
                                  stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </a>
                    <a class="glass-btn glass-btn-ghost"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='archive'}">
                        {translate key="navigation.archives"}
                    </a>
                </div>
            </div>

            {* Journal info glass card *}
            <aside class="glass-card hero-journal-card reveal reveal-delay-2"
                   aria-label="{translate key='plugins.themes.glassTheme.journalInfo'}">
                <div class="journal-meta">
                    {if $currentJournal->getData('onlineIssn')}
                    <div class="journal-meta-row">
                        <span>{translate key="journal.eIssn"}:</span>
                        <strong>{$currentJournal->getData('onlineIssn')|escape}</strong>
                    </div>
                    {/if}
                    {if $currentJournal->getData('printIssn')}
                    <div class="journal-meta-row">
                        <span>{translate key="journal.pIssn"}:</span>
                        <strong>{$currentJournal->getData('printIssn')|escape}</strong>
                    </div>
                    {/if}
                    <div class="journal-meta-row">
                        <span>{translate key="plugins.themes.glassTheme.frequency"}:</span>
                        <strong>
                            {$currentJournal->getData('publishingFrequency')|default:
                                translate key="plugins.themes.glassTheme.frequency.biannual"|escape}
                        </strong>
                    </div>
                </div>

                <span class="badge badge-success">
                    {translate key="plugins.themes.glassTheme.peerReviewed"}
                </span>

                <hr class="divider">

                {if $currentIssue}
                    <div style="font-size:.75rem;color:var(--glass-text-muted);margin-bottom:.375rem;">
                        {translate key="plugins.themes.glassTheme.currentIssue"}
                    </div>
                    <div style="font-size:.9rem;color:var(--glass-text);font-weight:600;line-height:1.4;">
                        {$currentIssue->getLocalizedTitle()|default:
                            "Vol. {$currentIssue->getVolume()} No. {$currentIssue->getNumber()} ({$currentIssue->getYear()})"|escape}
                    </div>
                {/if}
            </aside>
        </div>
    </section>

    {* ── Current Issue ─────────────────────────────────────────────────────── *}
    {if $currentIssue && $publishedArticles}
    <section class="section" aria-labelledby="current-issue-heading">
        <div class="page-container">
            <div class="section-header reveal">
                <span class="section-eyebrow">
                    {translate key="plugins.themes.glassTheme.latestIssue"}
                </span>
                <h2 class="section-title" id="current-issue-heading">
                    {$currentIssue->getLocalizedTitle()|default:
                        "Vol. {$currentIssue->getVolume()} No. {$currentIssue->getNumber()} ({$currentIssue->getYear()})"|escape}
                </h2>
                {if $currentIssue->getLocalizedDescription()}
                    <p class="section-subtitle">
                        {$currentIssue->getLocalizedDescription()|strip_tags|truncate:200:"…"|escape}
                    </p>
                {/if}
            </div>

            <div class="card-grid">
                {foreach from=$publishedArticles item=article name=articles}
                    {if $smarty.foreach.articles.index >= 6}{break}{/if}
                    <article class="glass-card article-card reveal reveal-delay-{$smarty.foreach.articles.index|string_format:"%d" + 1}"
                             aria-labelledby="article-{$article->getId()}-title">

                        {if $article->getSectionTitle()}
                            <div class="article-card-section">{$article->getSectionTitle()|escape}</div>
                        {/if}

                        <h3 class="article-card-title" id="article-{$article->getId()}-title">
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                          page='article' op='view' path=$article->getBestId()}">
                                {$article->getLocalizedTitle()|escape}
                            </a>
                        </h3>

                        {assign var="authors" value=$article->getAuthors()}
                        {if $authors}
                            <div class="article-card-authors">
                                {foreach from=$authors item=author name=authorLoop}
                                    {$author->getFullName()|escape}{if not $smarty.foreach.authorLoop.last}, {/if}
                                {/foreach}
                            </div>
                        {/if}

                        <div class="article-card-footer">
                            <span>{$article->getDatePublished()|date_format:$dateFormatShort}</span>
                            <a class="article-card-read"
                               href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                          page='article' op='view' path=$article->getBestId()}"
                               aria-label="{translate key='submission.read'} {$article->getLocalizedTitle()|escape}">
                                {translate key="plugins.themes.glassTheme.readMore"}
                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none" aria-hidden="true">
                                    <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1.5"
                                          stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </a>
                        </div>
                    </article>
                {/foreach}
            </div>

            <div style="text-align:center;margin-top:2.5rem;" class="reveal">
                <a class="glass-btn glass-btn-ghost"
                   href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='current'}">
                    {translate key="plugins.themes.glassTheme.viewAllArticles"}
                </a>
            </div>
        </div>
    </section>
    {/if}

    {* ── Announcements ─────────────────────────────────────────────────────── *}
    {if $announcements}
    <section class="section" aria-labelledby="announcements-heading"
             style="padding-top:0;">
        <div class="page-container">
            <div class="section-header reveal">
                <span class="section-eyebrow">
                    {translate key="announcement.announcements"}
                </span>
                <h2 class="section-title" id="announcements-heading">
                    {translate key="plugins.themes.glassTheme.latestNews"}
                </h2>
            </div>
            <div class="card-grid" style="grid-template-columns:repeat(auto-fill,minmax(320px,1fr));">
                {foreach from=$announcements item=announcement name=news}
                    {if $smarty.foreach.news.index >= 3}{break}{/if}
                    <div class="glass-card-sm reveal reveal-delay-{$smarty.foreach.news.index + 1}"
                         style="padding:1.25rem;">
                        <div style="font-size:.7rem;color:var(--glass-text-subtle);margin-bottom:.5rem;">
                            {$announcement->getDatePosted()|date_format:$dateFormatShort}
                        </div>
                        <h3 style="font-size:.95rem;font-weight:650;color:var(--glass-text);
                                   margin-bottom:.5rem;line-height:1.4;">
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                          page='announcement' op='view'
                                          path=$announcement->getId()}"
                               style="color:inherit;text-decoration:none;">
                                {$announcement->getLocalizedTitle()|escape}
                            </a>
                        </h3>
                        <p style="font-size:.825rem;color:var(--glass-text-muted);line-height:1.6;">
                            {$announcement->getLocalizedDescriptionShort()|strip_tags|truncate:140:"…"|escape}
                        </p>
                    </div>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

</main>

{include file="frontend/components/footer.tpl"}
