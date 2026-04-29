{**
 * @file templates/frontend/pages/userRegisterPending.tpl
 *
 * Glass Theme — Registration pending page (email verification required)
 *}
{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="message-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
            style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{$currentJournal->getLocalizedName()|escape}</span>
            <h1 class="section-title" id="message-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="user.register.registrationPending"}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="glass-card" style="padding: 2.5rem; max-width: 900px; margin: 0 auto; text-align: center;">
                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8; margin-bottom: 2.5rem;">
                    <p>{translate key="user.register.registrationPending.instructions"}</p>
                </div>

                <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="index"}" class="glass-btn glass-btn-primary" style="padding: 1rem 2rem;">
                        {translate key="navigation.archives.continueBrowsing"}
                    </a>
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" class="glass-btn" style="padding: 1rem 2rem; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border);">
                        {translate key="user.login"}
                    </a>
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}