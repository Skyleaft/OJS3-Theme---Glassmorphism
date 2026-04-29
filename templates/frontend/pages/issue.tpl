{**
 * @file templates/frontend/pages/issue.tpl
 *
 * Glass Theme — Single Issue view (Table of Contents)
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── Issue Hero ──────────────────────────────────────────────────────── *}
    <section class="search-hero" aria-labelledby="issue-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
            style="width:500px;height:500px;top:-150px;left:-100px;opacity:.4;"></div>

        <div style="position:relative;z-index:1; max-width: 1000px; margin: 0 auto;">
            <span class="section-eyebrow">
                {if $issue->getVolume()}Vol. {$issue->getVolume()|escape}{/if}
                {if $issue->getNumber()} No. {$issue->getNumber()|escape}{/if}
                ({$issue->getYear()|escape})
            </span>
            <h1 class="section-title" id="issue-heading" style="margin:.5rem 0 1rem;">
                {if $issue->getLocalizedTitle()}
                    {$issue->getLocalizedTitle()|escape}
                {else}
                    {$issue->getIssueIdentification()|escape}
                {/if}
            </h1>

            {if $issue->getDatePublished()}
                <p style="color: var(--glass-text-muted); font-size: .9rem;">
                    <strong>{translate key="submissions.published"}:</strong>
                    {$issue->getDatePublished()|date_format:$dateFormatShort}
                </p>
            {/if}
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">

            <div class="article-layout" style="padding-top: 0; align-items: stretch;">

                {* ── Main TOC ────────────────────────────────────────────────── *}
                <div class="article-main">

                    {* Issue Description / Editorial *}
                    {if $issue->getLocalizedDescription()}
                        <div class="glass-card" style="padding: 2.5rem; margin-bottom: 2.5rem;">
                            <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8;">
                                {$issue->getLocalizedDescription()|strip_unsafe_html}
                            </div>
                        </div>
                    {/if}

                    {* Table of Contents sections *}
                    {foreach from=$publishedSubmissions item=section}
                        <div class="toc-section" style="margin-bottom: 3rem;">
                            <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem;">
                                <h2 class="sidebar-title" style="margin-bottom: 0; white-space: nowrap;">
                                    {$section.title|escape}
                                </h2>
                                <div style="height: 1px; background: var(--glass-border); flex: 1;"></div>
                            </div>

                            <div style="display: flex; flex-direction: column; gap: 1.25rem;">
                                {foreach from=$section.articles item=article}
                                    {assign var="publication" value=$article->getCurrentPublication()}
                                    <div class="glass-card article-row-card"
                                        style="padding: 1.5rem; transition: transform .2s ease, background .2s ease;">
                                        <div
                                            style="display: flex; justify-content: space-between; align-items: flex-start; gap: 1.5rem;">
                                            <div style="flex: 1;">
                                                <h3
                                                    style="font-size: 1.1rem; margin-bottom: .5rem; line-height: 1.4; font-weight: 600;">
                                                    <a href="{url page="article" op="view" path=$article->getBestId()}"
                                                        style="color: inherit; text-decoration: none; transition: color .2s;">
                                                        {$publication->getLocalizedData('title')|strip_tags}
                                                    </a>
                                                </h3>

                                                <div
                                                    style="font-size: .85rem; color: var(--glass-text-muted); margin-bottom: 1.25rem; font-weight: 500;">
                                                    {$publication->getAuthorString($authorUserGroups)|escape}
                                                </div>

                                                <div style="display: flex; align-items: center; gap: .75rem; flex-wrap: wrap;">
                                                    {foreach from=$publication->getData('galleys') item=galley}
                                                        <a class="glass-btn glass-btn-primary"
                                                            style="padding: .4rem .85rem; font-size: .75rem; border-radius: .5rem; font-weight: 600;"
                                                            href="{url page="article" op="view" path=$article->getBestId()|to_array:$galley->getBestGalleyId()}">
                                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2.5"
                                                                style="margin-right: .3rem;">
                                                                <path
                                                                    d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z">
                                                                </path>
                                                                <polyline points="14 2 14 8 20 8"></polyline>
                                                                <line x1="16" y1="13" x2="8" y2="13"></line>
                                                                <line x1="16" y1="17" x2="8" y2="17"></line>
                                                            </svg>
                                                            {$galley->getGalleyLabel()|escape}
                                                        </a>
                                                    {/foreach}
                                                </div>
                                            </div>

                                            {if $publication->getData('pages')}
                                                <div style="text-align: right; min-width: 60px;">
                                                    <span class="badge badge-accent"
                                                        style="font-size: .7rem; padding: .25rem .6rem; border-radius: .4rem; letter-spacing: .02em; opacity: .9;">
                                                        pp. {$publication->getData('pages')|escape}
                                                    </span>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/foreach}
                </div>

                {* ── Sidebar ─────────────────────────────────────────────────── *}
                <aside class="article-sidebar" style="width: 320px;">
                    {if $issue->getLocalizedCoverImageUrl()}
                        <div class="glass-card" style="padding: 1rem; margin-bottom: 1.5rem; overflow: hidden;">
                            <img src="{$issue->getLocalizedCoverImageUrl()|escape}"
                                alt="{$issue->getIssueIdentification()|escape}"
                                style="width: 100%; height: auto; border-radius: .5rem;">
                        </div>
                    {/if}

                    <div class="glass-card" style="padding: 1.5rem;">
                        <h3 class="sidebar-title">{translate key="plugins.themes.glassTheme.journalInfo"}</h3>
                        <div style="margin-top: 1rem; display: flex; flex-direction: column; gap: .75rem;">
                            <div class="meta-row"
                                style="padding: .75rem; background: rgba(255,255,255,0.03); border-radius: .5rem; border: 1px solid var(--glass-border); flex-direction: column; align-items: flex-start;">
                                <div
                                    style="font-size: .7rem; color: var(--glass-text-subtle); text-transform: uppercase;">
                                    {translate key="journal.pIssn"}</div>
                                <div style="font-size: .9rem; font-weight: 600;">
                                    {$currentJournal->getData('printIssn')|escape}</div>
                            </div>
                            <div class="meta-row"
                                style="padding: .75rem; background: rgba(255,255,255,0.03); border-radius: .5rem; border: 1px solid var(--glass-border); flex-direction: column; align-items: flex-start;">
                                <div
                                    style="font-size: .7rem; color: var(--glass-text-subtle); text-transform: uppercase;">
                                    {translate key="journal.eIssn"}</div>
                                <div style="font-size: .9rem; font-weight: 600;">
                                    {$currentJournal->getData('onlineIssn')|escape}</div>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </section>

</main>

<style>
    .article-row-card:hover h3 a {
        color: var(--color-accent-light) !important;
    }

    @media (max-width: 1024px) {
        .article-layout {
            grid-template-columns: 1fr;
        }

        .article-sidebar {
            width: 100% !important;
            order: -1;
            margin-bottom: 2rem;
        }
    }
</style>

{include file="frontend/components/footer.tpl"}