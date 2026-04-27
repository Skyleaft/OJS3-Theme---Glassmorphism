{**
 * @file templates/frontend/pages/userRegister.tpl
 *
 * Glass Theme — Registration page with split layout
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="section" style="padding-top: 6rem; min-height: 100vh; position: relative; overflow: hidden;">
        
        {* Decorative Orbs *}
        <div class="hero-orb hero-orb-1" aria-hidden="true" style="width:600px;height:600px;top:-100px;right:-100px;opacity:.25;"></div>
        <div class="hero-orb hero-orb-2" aria-hidden="true" style="width:400px;height:400px;bottom:-50px;left:-50px;opacity:.15;"></div>

    <div class="page-container" style="max-width: 1100px; position: relative; z-index: 1;">
            
            <div class="registration-layout" style="display: grid; grid-template-columns: 1fr; gap: 3rem; align-items: start;">
                
                {* Left Side: Info & Welcome (Hidden on mobile via media query in manual.css if defined, but using inline for now) *}
                <div class="registration-info" style="padding-top: 2rem;">
                    <span class="section-eyebrow" style="margin-bottom: 1rem; display: block;">{translate key="navigation.user"}</span>
                    <h1 class="section-title" style="font-size: 2.5rem; margin-bottom: 1.5rem; line-height: 1.1; text-align: left;">
                        {translate key="user.register"}
                    </h1>
                    <p style="color: var(--glass-text-muted); font-size: 1.05rem; line-height: 1.6; margin-bottom: 3rem;">
                        {translate key="plugins.themes.glassTheme.register.instruction"}
                    </p>

                    <div style="display: flex; flex-direction: column; gap: 2rem;">
                        <div style="display: flex; gap: 1.25rem;">
                            <div style="flex-shrink: 0; width: 48px; height: 48px; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border); border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem;">
                                📝
                            </div>
                            <div>
                                <h3 style="font-size: 1.1rem; font-weight: 600; color: var(--glass-text); margin-bottom: .25rem;">{translate key="author.submit"}</h3>
                                <p style="font-size: .9rem; color: var(--glass-text-muted);">Manage and track your research submissions easily within our modern platform.</p>
                            </div>
                        </div>
                        <div style="display: flex; gap: 1.25rem;">
                            <div style="flex-shrink: 0; width: 48px; height: 48px; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border); border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem;">
                                🔍
                            </div>
                            <div>
                                <h3 style="font-size: 1.1rem; font-weight: 600; color: var(--glass-text); margin-bottom: .25rem;">Peer Review</h3>
                                <p style="font-size: .9rem; color: var(--glass-text-muted);">Contribute to the scholarly community by participating in our rigorous peer-review process.</p>
                            </div>
                        </div>
                        <div style="display: flex; gap: 1.25rem;">
                            <div style="flex-shrink: 0; width: 48px; height: 48px; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border); border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem;">
                                📬
                            </div>
                            <div>
                                <h3 style="font-size: 1.1rem; font-weight: 600; color: var(--glass-text); margin-bottom: .25rem;">Stay Informed</h3>
                                <p style="font-size: .9rem; color: var(--glass-text-muted);">Get notified about the latest discoveries, journal announcements, and new issues.</p>
                            </div>
                        </div>
                    </div>
                </div>

                {* Right Side: Form *}
                <div class="glass-card" style="padding: 3rem; border-radius: 1.5rem;">
                    
                    <form class="register-form" method="post" action="{$registerUrl}">
                        {csrf}
                        {if $source}<input type="hidden" name="source" value="{$source|escape}" />{/if}
                        
                        {if $errors}
                            <div style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); padding: 1rem; border-radius: .75rem; margin-bottom: 2rem; color: #fca5a5; font-size: .9rem;">
                                {include file="common/formErrors.tpl"}
                            </div>
                        {/if}

                        {* Group 1: Identity *}
                        <div style="margin-bottom: 3rem;">
                            <div style="display: flex; align-items: center; gap: .75rem; margin-bottom: 1.5rem;">
                                <span style="font-family: serif; font-style: italic; font-size: 1.25rem; color: var(--color-accent-light); opacity: 0.5;">01.</span>
                                <h2 style="font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; letter-spacing: 0.1em; border-bottom: 1px solid var(--glass-border); flex-grow: 1; padding-bottom: .25rem;">
                                    Personal Identity
                                </h2>
                            </div>
                            
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem;">
                                <div>
                                    <label for="givenName" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.givenName"} <span style="color: #fca5a5;">*</span></label>
                                    <input type="text" name="givenName" id="givenName" class="glass-input" value="{$givenName|escape}" required placeholder="e.g. John">
                                </div>
                                <div>
                                    <label for="familyName" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.familyName"}</label>
                                    <input type="text" name="familyName" id="familyName" class="glass-input" value="{$familyName|escape}" placeholder="e.g. Doe">
                                </div>
                            </div>

                            <div style="margin-bottom: 1.5rem;">
                                <label for="affiliation" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.affiliation"} <span style="color: #fca5a5;">*</span></label>
                                <input type="text" name="affiliation" id="affiliation" class="glass-input" value="{$affiliation|escape}" required placeholder="University, Organization, or Institution">
                            </div>

                            <div>
                                <label for="country" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="common.country"} <span style="color: #fca5a5;">*</span></label>
                                <select name="country" id="country" class="glass-input" required style="appearance: none; background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20width%3D%2212%22%20height%3D%2212%22%20viewBox%3D%220%200%2012%2012%22%20fill%3D%22none%22%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%3E%3Cpath%20d%3D%22M3%205L6%208L9%205%22%20stroke%3D%22%2394a3b8%22%20stroke-width%3D%222%22%20stroke-linecap%3D%22round%22%20stroke-linejoin%3D%22round%22/%3E%3C/svg%3E'); background-repeat: no-repeat; background-position: right 1rem center; padding-right: 2.5rem;">
                                    <option value="">{translate key="common.selectCountry"}</option>
                                    {foreach from=$countries item=countryName key=countryCode}
                                        <option value="{$countryCode|escape}" {if $country == $countryCode}selected{/if}>{$countryName|escape}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        {* Group 2: Account *}
                        <div style="margin-bottom: 3rem;">
                            <div style="display: flex; align-items: center; gap: .75rem; margin-bottom: 1.5rem;">
                                <span style="font-family: serif; font-style: italic; font-size: 1.25rem; color: var(--color-accent-light); opacity: 0.5;">02.</span>
                                <h2 style="font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; letter-spacing: 0.1em; border-bottom: 1px solid var(--glass-border); flex-grow: 1; padding-bottom: .25rem;">
                                    Account Credentials
                                </h2>
                            </div>
                            
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem;">
                                <div>
                                    <label for="email" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.email"} <span style="color: #fca5a5;">*</span></label>
                                    <input type="email" name="email" id="email" class="glass-input" value="{$email|escape}" required placeholder="email@example.com">
                                </div>
                                <div>
                                    <label for="username" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.username"} <span style="color: #fca5a5;">*</span></label>
                                    <input type="text" name="username" id="username" class="glass-input" value="{$username|escape}" required autocomplete="username" placeholder="Choose a unique username">
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem;">
                                <div>
                                    <label for="password" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.password"} <span style="color: #fca5a5;">*</span></label>
                                    <input type="password" name="password" id="password" class="glass-input" required autocomplete="new-password" placeholder="••••••••">
                                </div>
                                <div>
                                    <label for="password2" style="display: block; font-size: .85rem; font-weight: 500; color: var(--glass-text); margin-bottom: .5rem;">{translate key="user.register.repeatPassword"} <span style="color: #fca5a5;">*</span></label>
                                    <input type="password" name="password2" id="password2" class="glass-input" required autocomplete="new-password" placeholder="••••••••">
                                </div>
                            </div>
                        </div>

                        {* Group 3: Roles & Permissions *}
                        <div style="margin-bottom: 3.5rem;">
                            <div style="display: flex; align-items: center; gap: .75rem; margin-bottom: 1.5rem;">
                                <span style="font-family: serif; font-style: italic; font-size: 1.25rem; color: var(--color-accent-light); opacity: 0.5;">03.</span>
                                <h2 style="font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; letter-spacing: 0.1em; border-bottom: 1px solid var(--glass-border); flex-grow: 1; padding-bottom: .25rem;">
                                    Journal Roles & Privacy
                                </h2>
                            </div>
                            
                            {if $userGroups}
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
                                    {foreach from=$userGroups item=userGroup}
                                        {if $userGroup->getPermitSelfRegistration()}
                                            <label style="display: flex; align-items: center; gap: 1rem; padding: 1rem; background: rgba(255,255,255,0.03); border: 1px solid var(--glass-border); border-radius: 1rem; cursor: pointer; transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1); hover:background:rgba(255,255,255,0.06); hover:border-color:var(--color-accent-light);">
                                                <input type="checkbox" name="readerRole[{$userGroup->getId()}]" value="1" {if in_array($userGroup->getId(), $userGroupIds)}checked{/if} style="accent-color: var(--color-accent); transform: scale(1.15);">
                                                <div>
                                                    <span style="display: block; font-size: .95rem; font-weight: 600; color: var(--glass-text);">{$userGroup->getLocalizedName()|escape}</span>
                                                    <span style="display: block; font-size: .75rem; color: var(--glass-text-muted);">Register as a {$userGroup->getLocalizedName()|lower}</span>
                                                </div>
                                            </label>
                                        {/if}
                                    {/foreach}
                                </div>
                            {/if}

                            <label style="display: flex; align-items: flex-start; gap: 1rem; color: var(--glass-text-muted); cursor: pointer; font-size: .9rem; line-height: 1.6; padding: 1rem; background: rgba(255,255,255,0.02); border-radius: 1rem;">
                                <input type="checkbox" name="privacyConsent" value="1" {if $privacyConsent}checked{/if} required style="accent-color: var(--color-accent); margin-top: .35rem; transform: scale(1.15);">
                                <span>
                                    {capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
                                    {translate key="user.register.privacyConsent" privacyUrl=$privacyUrl}
                                </span>
                            </label>
                        </div>

                        <button type="submit" class="glass-btn glass-btn-primary" style="width: 100%; justify-content: center; padding: 1.25rem; font-size: 1.1rem; height: auto; border-radius: 1rem;">
                            {translate key="user.register"}
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" style="margin-left: .75rem;">
                                <path d="M5 12h14M12 5l7 7-7 7" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </button>

                        <div style="margin-top: 2.5rem; text-align: center; font-size: .95rem; color: var(--glass-text-muted);">
                            {translate key="plugins.themes.glassTheme.register.alreadyHaveAccount"}
                            <a href="{url page="login"}" style="color: var(--color-accent-light); font-weight: 700; text-decoration: none; margin-left: .5rem; border-bottom: 1px solid transparent; hover:border-color:currentColor;">
                                {translate key="user.login"}
                            </a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
