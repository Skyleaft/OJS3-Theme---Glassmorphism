{**
 * @file templates/frontend/pages/issueArchive.tpl
 *
 * Glass Theme — Issue archive page
 * Displays all issues as glass cards in a responsive grid
 *}

{include file="frontend/components/header.tpl"}
{include file="frontend/components/breadcrumbs.tpl"}

<main id="main-content" class="page-fade">
    <section class="section" style="padding-top:6rem;">
        <div class="page-container">

            <div class="section-header reveal">
                <span class="section-eyebrow">
                    {translate key="plugins.themes.glassTheme.browseContent"}
                </span>
                <h1 class="section-title">{translate key="navigation.archives"}</h1>
                <p class="section-subtitle">
                    {translate key="plugins.themes.glassTheme.archiveSubtitle"}
                </p>
            </div>

            {if $issues}
            <div class="card-grid"
                 style="grid-template-columns:repeat(auto-fill,minmax(240px,1fr));gap:1.75rem;">

                {foreach from=$issues item=issue name=issueLoop}
                <article class="glass-card issue-card reveal reveal-delay-{min($smarty.foreach.issueLoop.index + 1, 4)}"
                         aria-labelledby="issue-{$issue->getId()}-title">

                    {* Cover image *}
                    {if $issue->hasCoverImage()}
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                       page='issue' op='view'
                                       path=$issue->getBestIssueId()}"
                           tabindex="-1" aria-hidden="true">
                            <img class="issue-cover"
                                 src="{$issue->getCoverImageUrl($currentJournal->getId())|escape}"
                                 alt="{$issue->getLocalizedCoverImageAlt()|escape}">
                        </a>
                    {else}
                        {* Placeholder cover *}
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                       page='issue' op='view'
                                       path=$issue->getBestIssueId()}"
                           tabindex="-1" aria-hidden="true">
                            <div class="issue-cover"
                                 style="background:linear-gradient(135deg,
                                            rgba(99,102,241,.25),
                                            rgba(16,185,129,.15));
                                        display:flex;align-items:center;
                                        justify-content:center;font-size:2.5rem;">
                                📄
                            </div>
                        </a>
                    {/if}

                    <div class="issue-vol">
                        {translate key="issue.vol"} {$issue->getVolume()}
                        {if $issue->getNumber()}
                            · {translate key="issue.no"} {$issue->getNumber()}
                        {/if}
                    </div>

                    <h2 class="issue-title" id="issue-{$issue->getId()}-title">
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                       page='issue' op='view'
                                       path=$issue->getBestIssueId()}"
                           style="color:inherit;text-decoration:none;">
                            {if $issue->getLocalizedTitle()}
                                {$issue->getLocalizedTitle()|escape}
                            {else}
                                {translate key="issue.issue"}
                                {$issue->getVolume()}/{$issue->getNumber()}
                                ({$issue->getYear()})
                            {/if}
                        </a>
                    </h2>

                    {if $issue->getYear()}
                    <div style="font-size:.775rem;color:var(--glass-text-subtle);">
                        {$issue->getYear()}
                    </div>
                    {/if}

                    <a class="article-card-read"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                   page='issue' op='view'
                                   path=$issue->getBestIssueId()}"
                       style="margin-top:auto;"
                       aria-label="{translate key='plugins.themes.glassTheme.viewIssue'}
                                   {$issue->getLocalizedTitle()|escape}">
                        {translate key="plugins.themes.glassTheme.viewIssue"}
                        <svg width="12" height="12" viewBox="0 0 12 12" fill="none" aria-hidden="true">
                            <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1.5"
                                  stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </a>
                </article>
                {/foreach}

            </div>

            {* Pagination *}
            {include file="frontend/components/pagination.tpl"}

            {else}
                <div class="glass-card" style="padding:3rem;text-align:center;">
                    <p style="color:var(--glass-text-muted);">
                        {translate key="plugins.themes.glassTheme.noIssues"}
                    </p>
                </div>
            {/if}

        </div>
    </section>
</main>

{include file="frontend/components/footer.tpl"}
