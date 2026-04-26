{**
 * @file templates/frontend/pages/privacy.tpl
 *
 * Glass Theme — Privacy Policy page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="privacy-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
            style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="about.aboutTheJournal"}</span>
            <h1 class="section-title" id="privacy-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="about.privacyStatement"}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="glass-card" style="padding: 2.5rem; max-width: 900px; margin: 0 auto;">
                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8;">
                    {if $privacyStatement}
                        {$privacyStatement}
                    {else}
                        <p style="text-align: center; padding: 2rem 0;">
                            {translate key="about.privacyStatement.noStatement"}
                        </p>
                    {/if}
                </div>

                <div
                    style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--glass-border); text-align: center;">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about'}"
                        class="glass-btn glass-btn-ghost">
                        {translate key="navigation.about"}
                    </a>
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}