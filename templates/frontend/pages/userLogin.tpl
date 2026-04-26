{**
 * @file templates/frontend/pages/userLogin.tpl
 *
 * Glass Theme — Login page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="section" style="min-height: 80vh; display: flex; align-items: center; justify-content: center; position: relative;">
        
        {* Decorative Orbs *}
        <div class="hero-orb hero-orb-1" aria-hidden="true" style="width:400px;height:400px;top:10%;left:10%;opacity:.4;"></div>
        <div class="hero-orb hero-orb-2" aria-hidden="true" style="width:350px;height:350px;bottom:10%;right:10%;opacity:.3;"></div>

        <div class="page-container" style="width: 100%; max-width: 480px; position: relative; z-index: 1;">
            <div class="glass-card" style="padding: 3rem 2.5rem;">
                
                <div style="text-align: center; margin-bottom: 2.5rem;">
                    <h1 class="section-title" style="font-size: 1.75rem; margin-bottom: .5rem;">
                        {translate key="user.login"}
                    </h1>
                    <p style="color: var(--glass-text-muted); font-size: .9rem;">
                        {translate key="plugins.themes.glassTheme.login.welcomeBack"}
                    </p>
                </div>

                {if $loginMessage}
                    <div class="badge badge-accent" style="width: 100%; justify-content: center; margin-bottom: 1.5rem; padding: .75rem; border-radius: .5rem;">
                        {translate key=$loginMessage}
                    </div>
                {/if}

                {if $error}
                    <div style="background: rgba(239, 68, 68, 0.15); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); padding: .75rem; border-radius: .5rem; margin-bottom: 1.5rem; font-size: .85rem; text-align: center;">
                        {translate key=$error}
                    </div>
                {/if}

                <form class="login-form" method="post" action="{$loginUrl}">
                    {csrf}
                    <input type="hidden" name="source" value="{$source|escape}" />

                    <div style="margin-bottom: 1.25rem;">
                        <label for="username" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem; margin-left: .25rem;">
                            {translate key="user.username"}
                        </label>
                        <input type="text" name="username" id="username" class="glass-input" 
                               value="{$username|escape}" autocomplete="username" required>
                    </div>

                    <div style="margin-bottom: 1rem;">
                        <label for="password" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem; margin-left: .25rem;">
                            {translate key="user.password"}
                        </label>
                        <input type="password" name="password" id="password" class="glass-input" 
                               autocomplete="current-password" required>
                    </div>

                    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 2rem; font-size: .85rem;">
                        <label style="display: flex; align-items: center; gap: .5rem; color: var(--glass-text-muted); cursor: pointer;">
                            <input type="checkbox" name="remember" value="1" {if $remember}checked{/if} style="accent-color: var(--color-accent);">
                            {translate key="user.login.rememberMe"}
                        </label>
                        <a href="{url page="user" op="lostPassword"}" style="color: var(--color-accent-light); text-decoration: none;">
                            {translate key="user.login.forgotPassword"}
                        </a>
                    </div>

                    <button type="submit" class="glass-btn glass-btn-primary" style="width: 100%; justify-content: center; padding: .875rem;">
                        {translate key="user.login"}
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none" aria-hidden="true" style="margin-left: .25rem;">
                            <path d="M9 3l5 5-5 5M1 8h13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                </form>

                {if !$disableUserReg}
                <div style="margin-top: 2.5rem; text-align: center; font-size: .9rem; color: var(--glass-text-muted);">
                    {translate key="plugins.themes.glassTheme.login.noAccount"}
                    <a href="{url page="user" op="register" source=$source}" style="color: var(--color-accent-light); font-weight: 600; text-decoration: none; margin-left: .25rem;">
                        {translate key="plugins.themes.glassTheme.login.registerNow"}
                    </a>
                </div>
                {/if}
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
