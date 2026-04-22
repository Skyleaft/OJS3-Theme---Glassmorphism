{**
 * @file templates/frontend/pages/article.tpl
 *
 * Glass Theme — Article detail page
 * Layout: main content (title, abstract, galleys) + glass sidebar (metadata)
 *}

{include file="frontend/components/header.tpl"}
{include file="frontend/components/breadcrumbs.tpl"}

<main id="main-content" class="page-fade">
<div class="article-layout">

    {* ── Main column ──────────────────────────────────────────────────────── *}
    <div class="article-main">

        {* Section label *}
        {if $article->getSectionTitle()}
            <div class="article-card-section" style="margin-bottom:.75rem;font-size:.75rem;">
                {$article->getSectionTitle()|escape}
            </div>
        {/if}

        <h1 class="article-title">
            {$article->getLocalizedTitle()|escape}
        </h1>

        {* Authors *}
        {assign var="authors" value=$article->getAuthors()}
        {if $authors}
        <div class="article-authors-list" style="margin-bottom:1.75rem;">
            {foreach from=$authors item=author}
                <span class="author-chip">
                    {$author->getFullName()|escape}
                    {if $author->getLocalizedAffiliation()}
                        <span style="opacity:.6;margin-left:.15rem;">
                            · {$author->getLocalizedAffiliation()|escape|truncate:35:"…"}
                        </span>
                    {/if}
                </span>
            {/foreach}
        </div>
        {/if}

        {* DOI badge *}
        {if $article->getStoredPubId('doi')}
        <div style="margin-bottom:1.5rem;">
            <a href="https://doi.org/{$article->getStoredPubId('doi')|escape}"
               class="badge badge-accent" target="_blank" rel="noopener noreferrer"
               style="font-size:.75rem;">
                DOI: {$article->getStoredPubId('doi')|escape}
            </a>
        </div>
        {/if}

        {* Abstract *}
        {if $article->getLocalizedAbstract()}
        <div class="glass-card abstract-section reveal">
            <h2>{translate key="article.abstract"}</h2>
            <p>{$article->getLocalizedAbstract()|strip_tags|escape}</p>
        </div>
        {/if}

        {* Keywords *}
        {if $article->getLocalizedData('keywords')}
        <div class="reveal" style="margin-bottom:2rem;">
            <div style="font-size:.75rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;
                        color:var(--color-accent-light);margin-bottom:.6rem;">
                {translate key="article.subject"}
            </div>
            <div style="display:flex;flex-wrap:wrap;gap:.4rem;">
                {foreach from=$article->getLocalizedData('keywords') item=kw}
                    <span class="badge badge-accent">{$kw|escape}</span>
                {/foreach}
            </div>
        </div>
        {/if}

        {* Galleys / Download buttons *}
        {if $galleys}
        <div class="glass-card reveal" style="padding:1.5rem;margin-bottom:2rem;">
            <div class="sidebar-title">{translate key="submission.downloads"}</div>
            <div style="display:flex;flex-wrap:wrap;gap:.75rem;margin-top:.5rem;">
                {foreach from=$galleys item=galley}
                    <a class="glass-btn glass-btn-primary"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                   page='article' op='view'
                                   path=[$article->getBestId(), $galley->getBestGalleyId()]}"
                       aria-label="{translate key='submission.download'} {$galley->getGalleyLabel()|escape}">
                        <svg width="14" height="14" viewBox="0 0 14 14" fill="none" aria-hidden="true">
                            <path d="M7 1v8M3 9l4 4 4-4M1 12h12" stroke="currentColor"
                                  stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        {$galley->getGalleyLabel()|escape}
                    </a>
                {/foreach}
            </div>
        </div>
        {/if}

        {* Citations / References *}
        {if $article->getCitations()}
        <div class="glass-card reveal" style="padding:1.5rem;">
            <div class="sidebar-title">{translate key="submission.citations"}</div>
            <div style="font-size:.825rem;color:var(--glass-text-muted);
                        line-height:1.8;white-space:pre-line;">
                {$article->getCitations()|escape|nl2br}
            </div>
        </div>
        {/if}

    </div>

    {* ── Glass Sidebar ─────────────────────────────────────────────────────── *}
    <aside class="article-sidebar reveal reveal-delay-2"
           aria-label="{translate key='plugins.themes.glassTheme.articleInfo'}">

        {* Article metadata *}
        <div class="glass-card sidebar-section">
            <div class="sidebar-title">{translate key="plugins.themes.glassTheme.articleInfo"}</div>

            {if $issue}
            <div class="meta-row">
                <span class="meta-label">{translate key="issue.issue"}</span>
                <span class="meta-value">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                   page='issue' op='view' path=$issue->getBestIssueId()}"
                       style="color:var(--color-accent-light);text-decoration:none;">
                        Vol. {$issue->getVolume()} No. {$issue->getNumber()}
                    </a>
                </span>
            </div>
            {/if}

            {if $article->getDatePublished()}
            <div class="meta-row">
                <span class="meta-label">{translate key="submissions.published"}</span>
                <span class="meta-value">{$article->getDatePublished()|date_format:$dateFormatShort}</span>
            </div>
            {/if}

            {if $article->getPages()}
            <div class="meta-row">
                <span class="meta-label">{translate key="submission.pages"}</span>
                <span class="meta-value">{$article->getPages()|escape}</span>
            </div>
            {/if}

            {if $article->getStoredPubId('doi')}
            <div class="meta-row">
                <span class="meta-label">DOI</span>
                <span class="meta-value" style="word-break:break-all;">
                    <a href="https://doi.org/{$article->getStoredPubId('doi')|escape}"
                       target="_blank" rel="noopener noreferrer"
                       style="color:var(--color-accent-light);text-decoration:none;">
                        {$article->getStoredPubId('doi')|truncate:30:"…"|escape}
                    </a>
                </span>
            </div>
            {/if}
        </div>

        {* License *}
        {if $article->getLicenseURL()}
        <div class="glass-card-sm sidebar-section" style="padding:1.25rem;border-radius:.625rem;">
            <div class="sidebar-title">{translate key="submission.license"}</div>
            <a href="{$article->getLicenseURL()|escape}" target="_blank" rel="noopener noreferrer"
               style="font-size:.78rem;color:var(--color-accent-light);text-decoration:none;">
                {if $article->getCCLicenseBadge()}
                    {$article->getCCLicenseBadge()}
                {else}
                    {translate key="submission.license.view"}
                {/if}
            </a>
        </div>
        {/if}

        {* How to cite *}
        <div class="glass-card-sm sidebar-section" style="padding:1.25rem;border-radius:.625rem;">
            <div class="sidebar-title">{translate key="submission.howToCite"}</div>
            <p style="font-size:.775rem;color:var(--glass-text-muted);line-height:1.65;">
                {foreach from=$authors item=author name=al}
                    {$author->getFullName()|escape}{if not $smarty.foreach.al.last}, {/if}
                {/foreach}
                ({$article->getDatePublished()|date_format:"%Y"}).
                {$article->getLocalizedTitle()|escape}.
                <em>{$currentJournal->getLocalizedName()|escape}</em>,
                {if $issue}
                    {$issue->getVolume()}({$issue->getNumber()})
                    {if $article->getPages()}, {$article->getPages()|escape}{/if}.
                {/if}
                {if $article->getStoredPubId('doi')}
                    https://doi.org/{$article->getStoredPubId('doi')|escape}
                {/if}
            </p>
        </div>

    </aside>
</div>
</main>

{include file="frontend/components/footer.tpl"}
