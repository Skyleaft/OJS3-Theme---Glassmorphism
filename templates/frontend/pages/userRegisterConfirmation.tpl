{**
 * @file templates/frontend/pages/userRegisterConfirmation.tpl
 *
 * Glass Theme — Registration confirmation success page (after email verification)
 *}
{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="message-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
            style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{$currentJournal->getLocalizedName()|escape}</span>
            <h1 class="section-title" id="message-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="user.register.confirmAndActivate"}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="page user_confirm_activation glass-card" style="padding: 3.5rem 2.5rem; max-width: 650px; margin: 0 auto; text-align: center;">
                
                {* Activation Icon *}
                <div style="width: 80px; height: 80px; background: rgba(99, 102, 241, 0.15); border: 2px solid rgba(99, 102, 241, 0.3); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2.5rem; color: var(--color-accent-light);">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M9 12L11 14L15 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>

                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8; margin-bottom: 3rem; font-size: 1.1rem;">
                    <p>{translate key="user.register.confirmAndActivate.instructions" default="Please click the button below to confirm and activate your account."}</p>
                </div>

                <div style="display: flex; justify-content: center; gap: 1rem;">
                    <a href="{$activateUrl}" class="glass-btn glass-btn-primary" style="padding: 1.25rem 3.5rem; font-size: 1.15rem; width: 100%; max-width: 320px; justify-content: center;">
                        {translate key="user.register.activateAccount"}
                    </a>
                </div>

                <div style="margin-top: 2.5rem; padding-top: 2rem; border-top: 1px solid var(--glass-border); display: flex; justify-content: center; gap: 1.5rem; font-size: 0.9rem;">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="index"}" style="color: var(--glass-text-muted); text-decoration: none; transition: color 0.2s;" onmouseover="this.style.color='var(--glass-text)'" onmouseout="this.style.color='var(--glass-text-muted)'">
                        {translate key="navigation.homePage"}
                    </a>
                    <span style="color: var(--glass-border)">|</span>
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="contact"}" style="color: var(--glass-text-muted); text-decoration: none; transition: color 0.2s;" onmouseover="this.style.color='var(--glass-text)'" onmouseout="this.style.color='var(--glass-text-muted)'">
                        {translate key="about.contact"}
                    </a>
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}