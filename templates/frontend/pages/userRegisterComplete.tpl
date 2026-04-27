{**
 * @file templates/frontend/pages/userRegisterComplete.tpl
 *
 * Glass Theme — Registration success page
 *}
{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="section" style="min-height: 70vh; display: flex; align-items: center; justify-content: center; position: relative;">
        
        {* Decorative Orbs *}
        <div class="hero-orb hero-orb-1" aria-hidden="true" style="width:400px;height:400px;top:10%;left:10%;opacity:.3;"></div>
        <div class="hero-orb hero-orb-2" aria-hidden="true" style="width:350px;height:350px;bottom:10%;right:10%;opacity:.2;"></div>

        <div class="page-container" style="width: 100%; max-width: 600px; position: relative; z-index: 1;">
            <div class="glass-card" style="padding: 4rem 2.5rem; text-align: center;">
                
                {* Success Icon *}
                <div style="width: 80px; height: 80px; background: rgba(16, 185, 129, 0.15); border: 2px solid rgba(16, 185, 129, 0.3); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2.5rem; color: #10b981;">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>

                <div style="margin-bottom: 3rem;">
                    <h1 class="section-title" style="font-size: 2rem; margin-bottom: 1rem;">
                        {translate key="user.register.registrationCompleted"}
                    </h1>
                    <p style="color: var(--glass-text-muted); font-size: 1.1rem; line-height: 1.6;">
                        {translate key="user.register.registrationCompleted.instructions"}
                    </p>
                </div>

                <div style="display: flex; flex-direction: column; gap: 1rem; align-items: stretch; max-width: 320px; margin: 0 auto;">
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="submission" op="wizard"}" class="glass-btn glass-btn-primary" style="justify-content: center; padding: 1rem;">
                        <span>📝</span> {translate key="author.submit"}
                    </a>
                    
                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="profile"}" class="glass-btn" style="justify-content: center; padding: 1rem; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border);">
                        <span>👤</span> {translate key="user.profile.editProfile"}
                    </a>

                    <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="index"}" class="glass-btn" style="justify-content: center; padding: 1rem; background: transparent; border: 1px solid transparent;">
                        {translate key="navigation.archives.continueBrowsing"}
                    </a>
                </div>

            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
