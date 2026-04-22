{**
 * @file templates/frontend/pages/search.tpl
 *
 * Glass Theme — Search page
 * Includes: glass search hero, animated results, glass result cards,
 *           skeleton loading state, pagination.
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── Search Hero ─────────────────────────────────────────────────────── *}
    <section class="search-hero" aria-labelledby="search-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
             style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>
        <div class="hero-orb hero-orb-2" aria-hidden="true"
             style="width:250px;height:250px;bottom:-60px;right:15%;opacity:.5;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="common.search"}</span>
            <h1 class="section-title" id="search-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="plugins.themes.glassTheme.search.heading"}
            </h1>

            <form method="get"
                  action="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='search' op='search'}"
                  class="search-box" role="search">
                <label for="search-input" class="sr-only">{translate key="common.search"}</label>

                {* Search icon *}
                <svg class="search-icon" width="18" height="18" viewBox="0 0 18 18"
                     fill="none" aria-hidden="true">
                    <circle cx="8" cy="8" r="6" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M13 13l3 3" stroke="currentColor" stroke-width="1.6"
                          stroke-linecap="round"/>
                </svg>

                <input id="search-input"
                       class="glass-input"
                       type="search"
                       name="query"
                       value="{$query|escape}"
                       placeholder="{translate key='plugins.themes.glassTheme.search.placeholder'}"
                       autocomplete="off"
                       aria-label="{translate key='common.search'}">

                <button type="submit" class="glass-btn glass-btn-primary search-submit">
                    {translate key="common.search"}
                </button>
            </form>

            {* Keyboard hint *}
            <p style="font-size:.75rem;color:var(--glass-text-subtle);margin-top:.875rem;">
                {translate key="plugins.themes.glassTheme.search.tip"}
                <kbd style="padding:.1rem .35rem;border:1px solid var(--glass-border);
                             border-radius:.25rem;font-family:monospace;font-size:.75rem;">/</kbd>
            </p>
        </div>
    </section>

    {* ── Results ─────────────────────────────────────────────────────────── *}
    <section class="section" style="padding-top:1.5rem;">
        <div class="page-container">

            {if $query}
                {* Result count *}
                <div class="reveal" style="margin-bottom:1.5rem;font-size:.875rem;
                                           color:var(--glass-text-muted);">
                    {if $results}
                        {translate key="plugins.themes.glassTheme.search.results"
                                   count=$results->getCount()
                                   query=$query|escape}
                    {else}
                        {translate key="plugins.themes.glassTheme.search.noResults"
                                   query=$query|escape}
                    {/if}
                </div>
            {/if}

            {if $results && $results->getCount()}
                <div style="display:flex;flex-direction:column;gap:1.25rem;">
                    {iterate from=results item=result name=resultLoop}
                    <article class="glass-card article-card reveal
                                    reveal-delay-{min($smarty.foreach.resultLoop.index + 1, 4)}"
                             aria-labelledby="result-{$result->getId()}-title">

                        {if $result->getSectionTitle()}
                            <div class="article-card-section">{$result->getSectionTitle()|escape}</div>
                        {/if}

                        <h2 class="article-card-title" id="result-{$result->getId()}-title">
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                           page='article' op='view'
                                           path=$result->getBestId()}">
                                {$result->getLocalizedTitle()|escape}
                            </a>
                        </h2>

                        {assign var="resultAuthors" value=$result->getAuthors()}
                        {if $resultAuthors}
                            <div class="article-card-authors">
                                {foreach from=$resultAuthors item=ra name=ral}
                                    {$ra->getFullName()|escape}{if not $smarty.foreach.ral.last}, {/if}
                                {/foreach}
                            </div>
                        {/if}

                        {if $result->getLocalizedAbstract()}
                            <p style="font-size:.85rem;color:var(--glass-text-muted);
                                      line-height:1.65;margin-top:.25rem;">
                                {$result->getLocalizedAbstract()|strip_tags|truncate:240:"…"|escape}
                            </p>
                        {/if}

                        <div class="article-card-footer">
                            <span>
                                {if $result->getDatePublished()}
                                    {$result->getDatePublished()|date_format:$dateFormatShort}
                                {/if}
                            </span>
                            <a class="article-card-read"
                               href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                           page='article' op='view'
                                           path=$result->getBestId()}"
                               aria-label="{translate key='submission.read'}
                                            {$result->getLocalizedTitle()|escape}">
                                {translate key="plugins.themes.glassTheme.readMore"}
                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                     aria-hidden="true">
                                    <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor"
                                          stroke-width="1.5" stroke-linecap="round"
                                          stroke-linejoin="round"/>
                                </svg>
                            </a>
                        </div>
                    </article>
                    {/iterate}
                </div>

                {include file="frontend/components/pagination.tpl"}

            {elseif $query}
                {* No results state *}
                <div class="glass-card reveal" style="padding:3rem;text-align:center;">
                    <div style="font-size:3rem;margin-bottom:1rem;" aria-hidden="true">🔍</div>
                    <h2 style="font-size:1.1rem;color:var(--glass-text);margin-bottom:.5rem;">
                        {translate key="plugins.themes.glassTheme.search.noResultsHeading"}
                    </h2>
                    <p style="font-size:.875rem;color:var(--glass-text-muted);">
                        {translate key="plugins.themes.glassTheme.search.noResultsHint"}
                    </p>
                </div>

            {else}
                {* Initial state — show search tips *}
                <div class="card-grid" style="grid-template-columns:repeat(auto-fill,minmax(260px,1fr));">
                    {foreach from=[
                        ['icon'=>'📖','key'=>'plugins.themes.glassTheme.search.tip1'],
                        ['icon'=>'👤','key'=>'plugins.themes.glassTheme.search.tip2'],
                        ['icon'=>'🏷️','key'=>'plugins.themes.glassTheme.search.tip3']
                    ] item=tip name=tips}
                    <div class="glass-card-sm reveal reveal-delay-{$smarty.foreach.tips.index + 1}"
                         style="padding:1.5rem;text-align:center;">
                        <div style="font-size:2rem;margin-bottom:.75rem;" aria-hidden="true">
                            {$tip.icon}
                        </div>
                        <p style="font-size:.85rem;color:var(--glass-text-muted);">
                            {translate key=$tip.key}
                        </p>
                    </div>
                    {/foreach}
                </div>
            {/if}

        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
