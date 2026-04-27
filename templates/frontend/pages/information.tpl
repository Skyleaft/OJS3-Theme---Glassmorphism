{**
 * @file templates/frontend/pages/information.tpl
 *
 * Glass Theme — Information page (For Readers/Authors/Librarians)
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="info-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
             style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>
        
        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{$currentJournal->getLocalizedName()|escape}</span>
            <h1 class="section-title" id="info-heading" style="margin:.5rem 0 1.5rem;">
                {if $pageTitle}
                    {$pageTitle|escape}
                {else}
                    {capture assign="pageTitleLongKey"}{$pageTitleKey}.long{/capture}
                    {translate key=$pageTitleLongKey|default:$pageTitleKey}
                {/if}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="glass-card" style="padding: 2.5rem; max-width: 900px; margin: 0 auto;">
                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8;">
                    {$content}
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
