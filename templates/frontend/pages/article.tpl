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
            {if $section}
                <div class="article-card-section" style="margin-bottom:.75rem;font-size:.75rem;">
                    {$section->getLocalizedTitle()|escape}
                </div>
            {/if}

            <h1 class="article-title">
                {$publication->getLocalizedData('title')|escape}
            </h1>

            {* Authors *}
            {assign var="authors" value=$publication->getData('authors')}
            {if $authors}
                <div class="article-authors-list" style="margin-bottom:1.75rem;">
                    {foreach from=$authors item=author}
                        <span class="author-chip">
                            {$author->getFullName()|escape}
                            {if $author->getLocalizedData('affiliation')}
                                <span style="opacity:.6;margin-left:.15rem;">
                                    · {$author->getLocalizedData('affiliation')|escape|truncate:35:"…"}
                                </span>
                            {/if}
                        </span>
                    {/foreach}
                </div>
            {/if}

            {* DOI badge *}
            {if $publication->getData('pub-id::doi')}
                <div style="margin-bottom:1.5rem;">
                    <a href="https://doi.org/{$publication->getData('pub-id::doi')|escape}" class="badge badge-accent"
                        target="_blank" rel="noopener noreferrer" style="font-size:.75rem;">
                        DOI: {$publication->getData('pub-id::doi')|escape}
                    </a>
                </div>
            {/if}

            {* Abstract *}
            {if $publication->getLocalizedData('abstract')}
                <div class="glass-card abstract-section reveal">
                    <h2>{translate key="article.abstract"}</h2>
                    <p>{$publication->getLocalizedData('abstract')|strip_tags|escape}</p>
                </div>
            {/if}

            {* Keywords *}
            {if $publication->getData('keywords')}
                <div class="reveal" style="margin-bottom:2rem;">
                    <div style="font-size:.75rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;
                        color:var(--color-accent-light);margin-bottom:.6rem;">
                        {translate key="article.subject"}
                    </div>
                    <div style="display:flex;flex-wrap:wrap;gap:.4rem;">
                        {foreach from=$publication->getData('keywords') item=kw}
                            <span class="badge badge-accent">{$kw|escape}</span>
                        {/foreach}
                    </div>
                </div>
            {/if}



            {* Citations / References *}
            {if $publication->getData('citationsRaw')}
                <div class="glass-card reveal" style="padding:1.5rem;">
                    <div class="sidebar-title">{translate key="submission.citations"}</div>
                    <div style="font-size:.825rem;color:var(--glass-text-muted);
                            line-height:1.8;white-space:pre-line;">
                        {$publication->getData('citationsRaw')|escape|nl2br}
                    </div>
                </div>
            {/if}

        </div>

        {* ── Glass Sidebar ─────────────────────────────────────────────────────── *}
        <aside class="article-sidebar reveal reveal-delay-2"
            aria-label="{translate key='plugins.themes.glassTheme.articleInfo'}">

            {* Galleys / Download buttons *}
            {assign var="articleGalleys" value=$publication->getData('galleys')}
            {if $articleGalleys}
                <div class="glass-card sidebar-section" style="padding: 1.25rem;">
                    <div class="sidebar-title">{translate key="submission.downloads"}</div>
                    <div style="display: flex; flex-direction: column; gap: .75rem; margin-top: .75rem;">
                        {foreach from=$articleGalleys item=galley}
                            <a class="glass-btn glass-btn-primary"
                                style="width: 100%; justify-content: flex-start; padding: .6rem 1rem; border-radius: .6rem; font-weight: 600;"
                                href="{url page="article" op="view" path=$article->getBestId()|to_array:$galley->getBestGalleyId()}"
                                aria-label="{translate key='submission.download'} {$galley->getGalleyLabel()|escape}">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2.5" style="margin-right: .5rem;">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                    <polyline points="14 2 14 8 20 8"></polyline>
                                    <line x1="16" y1="13" x2="8" y2="13"></line>
                                    <line x1="16" y1="17" x2="8" y2="17"></line>
                                </svg>
                                {$galley->getGalleyLabel()|escape}
                            </a>
                        {/foreach}
                    </div>
                </div>
            {/if}

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

                {if $publication->getData('datePublished')}
                    <div class="meta-row">
                        <span class="meta-label">{translate key="submissions.published"}</span>
                        <span
                            class="meta-value">{$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
                    </div>
                {/if}

                {if $publication->getData('pages')}
                    <div class="meta-row">
                        <span class="meta-label">{translate key="submission.pages"}</span>
                        <span class="meta-value">{$publication->getData('pages')|escape}</span>
                    </div>
                {/if}

                {if $publication->getData('pub-id::doi')}
                    <div class="meta-row">
                        <span class="meta-label">DOI</span>
                        <span class="meta-value" style="word-break:break-all;">
                            <a href="https://doi.org/{$publication->getData('pub-id::doi')|escape}" target="_blank"
                                rel="noopener noreferrer" style="color:var(--color-accent-light);text-decoration:none;">
                                {$publication->getData('pub-id::doi')|truncate:30:"…"|escape}
                            </a>
                        </span>
                    </div>
                {/if}
            </div>

            {* License *}
            {if $publication->getData('licenseUrl')}
                <div class="glass-card-sm sidebar-section" style="padding:1.25rem;border-radius:.625rem;">
                    <div class="sidebar-title">{translate key="submission.license"}</div>
                    <a href="{$publication->getData('licenseUrl')|escape}" target="_blank" rel="noopener noreferrer"
                        style="font-size:.78rem;color:var(--color-accent-light);text-decoration:none;">
                        {if $ccLicenseBadge}
                            {$ccLicenseBadge}
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
                    ({$publication->getData('datePublished')|date_format:"%Y"}).
                    {$publication->getLocalizedData('title')|escape}.
                    <em>{$currentJournal->getLocalizedName()|escape}</em>,
                    {if $issue}
                        {$issue->getVolume()}({$issue->getNumber()})
                        {if $publication->getData('pages')}, {$publication->getData('pages')|escape}{/if}.
                    {/if}
                    {if $publication->getData('pub-id::doi')}
                        https://doi.org/{$publication->getData('pub-id::doi')|escape}
                    {/if}
                </p>
            </div>

        </aside>
    </div>
</main>

{include file="frontend/components/footer.tpl"}