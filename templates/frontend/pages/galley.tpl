{**
 * @file templates/frontend/pages/galley.tpl
 *
 * Glass Theme — Galley view page
 * This template handles the "landing" view for galleys (e.g. HTML, XML).
 * For PDF galleys, OJS usually uses a plugin like pdfJsViewer.
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">
    <div class="galley-view-layout">

        {* ── Header Bar ────────────────────────────────────────────────────── *}
        <div class="galley-header-bar reveal">
            <div class="page-container">
                <div class="galley-header-inner">
                    <div class="galley-info">
                        <span class="section-eyebrow" style="margin-bottom: .25rem;">
                            {if $issue}
                                {$issue->getIssueIdentification()|escape}
                            {/if}
                        </span>
                        <h1 class="galley-article-title">
                            {$publication->getLocalizedData('title')|escape}
                        </h1>
                        <div class="galley-label-badge">
                            <span class="badge badge-accent">{$galley->getGalleyLabel()|escape}</span>
                        </div>
                    </div>

                    <div class="galley-actions">
                        <a href="{url page="article" op="view" path=$article->getBestId()}"
                            class="glass-btn glass-btn-ghost" title="{translate key="submission.returnToArticle"}">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" style="margin-right: .5rem;">
                                <path d="M19 12H5M12 19l-7-7 7-7" />
                            </svg>
                            {translate key="submission.returnToArticle"}
                        </a>
                        <a href="{url page="article" op="download" path=$article->getBestId()|to_array:$galley->getBestId()}"
                            class="glass-btn glass-btn-primary">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" style="margin-right: .5rem;">
                                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4M7 10l5 5 5-5M12 15V3" />
                            </svg>
                            {translate key="common.download"}
                        </a>
                    </div>
                </div>
            </div>
        </div>

        {* ── Galley Content Area ────────────────────────────────────────────── *}
        <div class="galley-content-container reveal reveal-delay-1">
            <div class="page-container">
                <div class="glass-card galley-card">
                    <div class="galley-iframe-wrapper">
                        {if $galley->isHtmlGalley()}
                            {* HTML galleys are usually displayed in an iframe *}
                            <iframe name="htmlGalleyFrame"
                                src="{url page="article" op="download" path=$article->getBestId()|to_array:$galley->getBestId() inline=true}"
                                allowfullscreen webkitallowfullscreen></iframe>
                        {else}
                            {* For other types, try to display them or provide a download message *}
                            <div class="galley-fallback">
                                <div style="font-size: 3rem; margin-bottom: 1.5rem; opacity: .3;">📄</div>
                                <h2>{translate key="submission.galleyFiles"}</h2>
                                <p>{translate key="plugins.themes.glassTheme.galley.downloadPrompt"}</p>
                                <a href="{url page="article" op="download" path=$article->getBestId()|to_array:$galley->getBestId()}"
                                    class="glass-btn glass-btn-primary" style="margin-top: 1.5rem;">
                                    {translate key="common.download"} {$galley->getGalleyLabel()|escape}
                                </a>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<style>
    .galley-view-layout {
        padding-bottom: 4rem;
    }

    /* Header Bar */
    .galley-header-bar {
        background: rgba(255, 255, 255, 0.01);
        border-bottom: 1px solid var(--glass-border);
        padding: 2.5rem 0;
        margin-bottom: 3rem;
        position: relative;
        overflow: hidden;
    }

    .galley-header-inner {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 2rem;
        position: relative;
        z-index: 1;
    }

    .galley-info {
        flex: 1;
        max-width: 800px;
    }

    .galley-article-title {
        font-size: 1.75rem;
        font-weight: 800;
        line-height: 1.2;
        margin-bottom: 1rem;
        color: var(--glass-text);
    }

    .galley-actions {
        display: flex;
        gap: 1rem;
        flex-shrink: 0;
        padding-top: 0.5rem;
    }

    /* Galley Content */
    .galley-card {
        padding: 0;
        overflow: hidden;
        border-radius: var(--radius-glass);
        height: 85vh;
        /* Large height for document viewing */
        background: white;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
    }

    [data-theme="dark"] .galley-card {
        background: #1e1e1e;
        border: 1px solid var(--glass-border);
    }

    .galley-iframe-wrapper {
        width: 100%;
        height: 100%;
        position: relative;
    }

    .galley-iframe-wrapper iframe {
        width: 100%;
        height: 100%;
        border: none;
    }

    .galley-fallback {
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 4rem;
        text-align: center;
    }

    @media (max-width: 768px) {
        .galley-header-inner {
            flex-direction: column;
            gap: 1.5rem;
        }

        .galley-actions {
            width: 100%;
        }

        .galley-actions .glass-btn {
            flex: 1;
            justify-content: center;
        }

        .galley-article-title {
            font-size: 1.4rem;
        }
    }
</style>

{include file="frontend/components/footer.tpl"}