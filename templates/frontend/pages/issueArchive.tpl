{**
 * @file templates/frontend/pages/issueArchive.tpl
 *
 * Glass Theme — Issue Archive page (List of all issues)
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── Archive Hero ────────────────────────────────────────────────────── *}
    <section class="search-hero" aria-labelledby="archive-heading">
        <div class="hero-orb hero-orb-2" aria-hidden="true" 
             style="width:400px;height:400px;bottom:-100px;right:10%;opacity:.5;"></div>
        
        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="navigation.archives"}</span>
            <h1 class="section-title" id="archive-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="plugins.themes.glassTheme.browseContent"}
            </h1>
            <p class="section-subtitle" style="max-width: 600px; margin: 0 auto;">
                {translate key="plugins.themes.glassTheme.archiveSubtitle"}
            </p>
        </div>
    </section>

    {* ── Issues Grid ──────────────────────────────────────────────────────── *}
    <section class="section" style="padding-top: 2rem;">
        <div class="page-container">
            
            {if $issues|@count}
                <div class="card-grid">
                    {foreach from=$issues item=issue}
                        <div class="glass-card issue-card">
                            <a href="{url op="view" path=$issue->getBestIssueId()}" class="issue-cover-link">
                                {if $issue->getLocalizedCoverImageUrl()}
                                    <img class="issue-cover" 
                                         src="{$issue->getLocalizedCoverImageUrl()|escape}" 
                                         alt="{$issue->getLocalizedCoverImageAltText()|escape|default:$issue->getIssueIdentification()|escape}">
                                {else}
                                    <div class="issue-cover-placeholder">
                                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                                        </svg>
                                        <span>{$issue->getIssueIdentification()|escape}</span>
                                    </div>
                                {/if}
                            </a>

                            <div class="issue-info" style="padding: 1.5rem; flex: 1; display: flex; flex-direction: column;">
                                <span class="issue-vol">
                                    {if $issue->getVolume()}Vol. {$issue->getVolume()|escape}{/if}
                                    {if $issue->getNumber()} No. {$issue->getNumber()|escape}{/if}
                                    ({$issue->getYear()|escape})
                                </span>
                                
                                <h3 class="issue-title" style="margin: .5rem 0 1.25rem; font-size: 1.1rem; line-height: 1.4;">
                                    <a href="{url op="view" path=$issue->getBestIssueId()}" style="color: inherit; text-decoration: none;">
                                        {if $issue->getLocalizedTitle()}
                                            {$issue->getLocalizedTitle()|escape}
                                        {else}
                                            {$issue->getIssueIdentification()|escape}
                                        {/if}
                                    </a>
                                </h3>

                                <div style="margin-top: auto;">
                                    <a href="{url op="view" path=$issue->getBestIssueId()}" class="glass-btn glass-btn-primary" style="width: 100%; justify-content: center;">
                                        {translate key="plugins.themes.glassTheme.viewIssue"}
                                    </a>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>

                {* Pagination *}
                {if $prevPage > 1}
                    {assign var="prevUrl" value="{url op="archive" path=$prevPage}"}
                {elseif $prevPage === 1}
                    {assign var="prevUrl" value="{url op="archive"}"}
                {/if}
                
                {if $nextPage}
                    {assign var="nextUrl" value="{url op="archive" path=$nextPage}"}
                {/if}

                {if $prevUrl || $nextUrl}
                    <div class="pagination" style="margin-top: 4rem;">
                        {if $prevUrl}
                            <a class="page-btn" href="{$prevUrl}" aria-label="{translate key="common.prevPage"}">
                                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M12.5 15l-5-5 5-5" />
                                </svg>
                            </a>
                        {/if}
                        
                        <span class="page-btn active">{$currentPage}</span>
                        
                        {if $nextUrl}
                            <a class="page-btn" href="{$nextUrl}" aria-label="{translate key="common.nextPage"}">
                                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M7.5 5l5 5-5 5" />
                                </svg>
                            </a>
                        {/if}
                    </div>
                {/if}

            {else}
                <div class="glass-card" style="padding: 4rem; text-align: center; max-width: 600px; margin: 0 auto;">
                    <div style="font-size: 3rem; margin-bottom: 1.5rem; opacity: .3;">📂</div>
                    <p style="color: var(--glass-text-muted); font-size: 1.1rem;">
                        {translate key="plugins.themes.glassTheme.noIssues"}
                    </p>
                </div>
            {/if}

        </div>
    </section>

</main>

<style>
.issue-card {
    display: flex;
    flex-direction: column;
    padding: 0;
    overflow: hidden;
    height: 100%;
}
.issue-cover-link {
    display: block;
    width: 100%;
    aspect-ratio: 3/4;
    overflow: hidden;
    border-bottom: 1px solid var(--glass-border);
}
.issue-cover {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}
.issue-card:hover .issue-cover {
    transform: scale(1.05);
}
.issue-cover-placeholder {
    width: 100%;
    height: 100%;
    background: rgba(255,255,255,0.03);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 1rem;
    color: var(--glass-text-subtle);
    padding: 2rem;
    text-align: center;
}
.issue-cover-placeholder span {
    font-size: .75rem;
    font-weight: 600;
}
</style>

{include file="frontend/components/footer.tpl"}
