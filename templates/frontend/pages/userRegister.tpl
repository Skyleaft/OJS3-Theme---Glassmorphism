{**
 * @file templates/frontend/pages/userRegister.tpl
 *
 * Glass Theme — Registration page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="section" style="padding-top: 6rem;">
        
        {* Decorative Orbs *}
        <div class="hero-orb hero-orb-1" aria-hidden="true" style="width:500px;height:500px;top:-100px;right:-100px;opacity:.3;"></div>

        <div class="page-container" style="max-width: 800px; position: relative; z-index: 1;">
            
            <div class="section-header" style="text-align: left; margin-bottom: 2.5rem;">
                <span class="section-eyebrow">{translate key="navigation.user"}</span>
                <h1 class="section-title">{translate key="user.register"}</h1>
                <p class="section-subtitle">{translate key="plugins.themes.glassTheme.register.instruction"}</p>
            </div>

            <div class="glass-card" style="padding: 2.5rem;">
                
                <form class="register-form" method="post" action="{$registerUrl}">
                    {csrf}

                    {if $source}
                        <input type="hidden" name="source" value="{$source|escape}" />
                    {/if}

                    {include file="common/formErrors.tpl"}

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                        {* Given Name *}
                        <div>
                            <label for="givenName" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                                {translate key="user.givenName"} <span style="color: #fca5a5;">*</span>
                            </label>
                            <input type="text" name="givenName" id="givenName" class="glass-input" value="{$givenName|escape}" required>
                        </div>

                        {* Family Name *}
                        <div>
                            <label for="familyName" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                                {translate key="user.familyName"}
                            </label>
                            <input type="text" name="familyName" id="familyName" class="glass-input" value="{$familyName|escape}">
                        </div>
                    </div>

                    <div style="margin-bottom: 2rem;">
                        <label for="affiliation" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                            {translate key="user.affiliation"} <span style="color: #fca5a5;">*</span>
                        </label>
                        <input type="text" name="affiliation" id="affiliation" class="glass-input" value="{$affiliation|escape}" required>
                    </div>

                    <div style="margin-bottom: 2rem;">
                        <label for="country" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                            {translate key="common.country"} <span style="color: #fca5a5;">*</span>
                        </label>
                        <select name="country" id="country" class="glass-input" required style="appearance: none; background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20width%3D%2212%22%20height%3D%2212%22%20viewBox%3D%220%200%2012%2012%22%20fill%3D%22none%22%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%3E%3Cpath%20d%3D%22M3%205L6%208L9%205%22%20stroke%3D%22%2394a3b8%22%20stroke-width%3D%222%22%20stroke-linecap%3D%22round%22%20stroke-linejoin%3D%22round%22/%3E%3C/svg%3E'); background-repeat: no-repeat; background-position: right 1rem center; padding-right: 2.5rem;">
                            <option value="">{translate key="common.selectCountry"}</option>
                            {foreach from=$countries item=countryName key=countryCode}
                                <option value="{$countryCode|escape}" {if $country == $countryCode}selected{/if}>{$countryName|escape}</option>
                            {/foreach}
                        </select>
                    </div>

                    <hr style="border: 0; border-top: 1px solid var(--glass-border); margin: 2.5rem 0;">

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                        {* Email *}
                        <div>
                            <label for="email" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                                {translate key="user.email"} <span style="color: #fca5a5;">*</span>
                            </label>
                            <input type="email" name="email" id="email" class="glass-input" value="{$email|escape}" required>
                        </div>

                        {* Username *}
                        <div>
                            <label for="username" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                                {translate key="user.username"} <span style="color: #fca5a5;">*</span>
                            </label>
                            <input type="text" name="username" id="username" class="glass-input" value="{$username|escape}" required autocomplete="username">
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2.5rem;">
                        {* Password *}
                        <div>
                            <label for="password" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                                {translate key="user.password"} <span style="color: #fca5a5;">*</span>
                            </label>
                            <input type="password" name="password" id="password" class="glass-input" required autocomplete="new-password">
                        </div>

                        {* Confirm Password *}
                        <div>
                            <label for="confirmPassword" style="display: block; font-size: .75rem; font-weight: 700; color: var(--color-accent-light); text-transform: uppercase; margin-bottom: .5rem;">
                                {translate key="user.register.repeatPassword"} <span style="color: #fca5a5;">*</span>
                            </label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="glass-input" required autocomplete="new-password">
                        </div>
                    </div>

                    {* User Groups / Roles *}
                    {if $userGroups}
                        <div style="margin-bottom: 2.5rem; padding: 1.5rem; background: rgba(255,255,255,0.03); border-radius: .75rem; border: 1px solid var(--glass-border);">
                            <h3 style="font-size: .85rem; font-weight: 700; color: var(--glass-text); margin-bottom: 1rem;">
                                {translate key="plugins.themes.glassTheme.register.as"}
                            </h3>
                            <div style="display: flex; flex-direction: column; gap: .75rem;">
                                {foreach from=$userGroups item=userGroup}
                                    {if $userGroup->getPermitSelfRegistration()}
                                        <label style="display: flex; align-items: flex-start; gap: .75rem; color: var(--glass-text-muted); cursor: pointer; font-size: .9rem;">
                                            <input type="checkbox" name="readerRole[{$userGroup->getId()}]" value="1" {if in_array($userGroup->getId(), $userGroupIds)}checked{/if} style="accent-color: var(--color-accent); margin-top: .25rem;">
                                            <span>{$userGroup->getLocalizedName()|escape}</span>
                                        </label>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    {/if}

                    <div style="margin-bottom: 2.5rem;">
                        <label style="display: flex; align-items: flex-start; gap: .75rem; color: var(--glass-text-muted); cursor: pointer; font-size: .9rem;">
                            <input type="checkbox" name="privacyConsent" value="1" {if $privacyConsent}checked{/if} required style="accent-color: var(--color-accent); margin-top: .25rem;">
                            <span>
                                {capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
                                {translate key="user.register.privacyConsent" privacyUrl=$privacyUrl}
                            </span>
                        </label>
                    </div>

                    <button type="submit" class="glass-btn glass-btn-primary" style="width: 100%; justify-content: center; padding: 1rem; font-size: 1rem;">
                        {translate key="user.register"}
                    </button>

                    <div style="margin-top: 2rem; text-align: center; font-size: .9rem; color: var(--glass-text-muted);">
                        {translate key="plugins.themes.glassTheme.register.alreadyHaveAccount"}
                        <a href="{url page="login"}" style="color: var(--color-accent-light); font-weight: 600; text-decoration: none; margin-left: .25rem;">
                            {translate key="user.login"}
                        </a>
                    </div>
                </form>

            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}
