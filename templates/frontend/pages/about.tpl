{**
 * @file templates/frontend/pages/about.tpl
 *
 * Glass Theme — About page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── About Hero ──────────────────────────────────────────────────────── *}
    <section class="search-hero" aria-labelledby="about-heading" style="padding-bottom: 2rem;">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
            style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="navigation.about"}</span>
            <h1 class="section-title" id="about-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="about.aboutTheJournal"}
            </h1>
        </div>
    </section>

    {* ── Main Content ────────────────────────────────────────────────────── *}
    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="glass-card" style="padding: 2.5rem; max-width: 900px; margin: 0 auto;">

                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8;">
                    {if $currentJournal->getLocalizedData('about')}
                        {$currentJournal->getLocalizedData('about')}
                    {else}
                        <p style="text-align: center; padding: 2rem 0;">
                            {translate key="about.aboutTheJournal.noDescription"}
                        </p>
                    {/if}
                </div>

                {* Optional: Editorial Team Link *}
                <div
                    style="margin-top: 3rem; padding-top: 2rem; border-top: 1px solid var(--glass-border); display: flex; gap: 1rem; flex-wrap: wrap;">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about' op='editorialTeam'}"
                        class="glass-btn glass-btn-ghost">
                        {translate key="about.editorialTeam"}
                    </a>
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about' op='submissions'}"
                        class="glass-btn glass-btn-ghost">
                        {translate key="about.submissions"}
                    </a>
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about' op='contact'}"
                        class="glass-btn glass-btn-ghost">
                        {translate key="about.contact"}
                    </a>
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}