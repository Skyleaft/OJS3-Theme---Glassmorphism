{**
 * @file templates/frontend/pages/editorialTeam.tpl
 *
 * Glass Theme — Editorial Team page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="editorial-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
             style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>
        
        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="about.aboutTheJournal"}</span>
            <h1 class="section-title" id="editorial-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="about.editorialTeam"}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="glass-card" style="padding: 2.5rem; max-width: 1000px; margin: 0 auto;">
                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8;">
                    {if $editorialTeam}
                        {$editorialTeam}
                    {else}
                        <p style="text-align: center; padding: 2rem 0;">
                            {translate key="about.editorialTeam.noTeam"}
                        </p>
                    {/if}
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
