{**
 * @file templates/frontend/components/header.tpl
 *
 * Glass Theme — Sticky glassmorphism navigation header
 *}
{capture assign="initialTheme"}{if $colorMode == 'light'}light{elseif $colorMode == 'dark'}dark{else}auto{/if}{/capture}
<!DOCTYPE html>
<html data-theme="dark" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<script>
    (function() {
        try {
            const STORAGE_KEY = 'glass-theme-color-mode';
            const setting = '{$initialTheme}';
            let theme = localStorage.getItem(STORAGE_KEY);
            
            if (!theme || theme === 'auto') {
                if (setting === 'auto') {
                    theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
                } else {
                    theme = setting;
                }
            }
            
            document.documentElement.setAttribute('data-theme', theme);
            if (theme === 'light') document.documentElement.classList.add('theme-light');
            else document.documentElement.classList.remove('theme-light');
        } catch (e) {}
    })();
</script>
<script src="{$baseUrl}/plugins/themes/glassTheme/js/glass-theme.js" defer></script>
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}" dir="{if $currentLocale|substr:0:2 == 'ar'}rtl{else}ltr{/if}">

    {* Skip-to-content for accessibility *}
    <a id="skip-to-content" class="sr-only" href="#main-content">
        {translate key="plugins.themes.glassTheme.skipToContent"}
    </a>

    {* Sticky glass nav *}
    <nav class="glass-nav site-nav" id="site-nav" role="navigation"
         aria-label="{translate key='common.navigation.site'}">
        <div class="nav-inner">

            {* Brand / Logo *}
            <a class="nav-brand" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='index'}"
               aria-label="{$currentJournal->getLocalizedName()|escape}">
                {if $currentJournal->getData('journalThumbnail')}
                    <img src="{$publicFilesDir}/{$currentJournal->getData('journalThumbnail')}"
                         alt="{$currentJournal->getLocalizedName()|escape}"
                         width="32" height="32"
                         style="border-radius:6px;object-fit:cover;">
                {else}
                    <svg width="30" height="30" viewBox="0 0 30 30" fill="none" aria-hidden="true">
                        <rect width="30" height="30" rx="7" fill="var(--color-accent)" opacity=".9"/>
                        <text x="15" y="21" text-anchor="middle" fill="white"
                              font-family="Inter,sans-serif" font-size="14" font-weight="700">J</text>
                    </svg>
                {/if}
                <span>{$currentJournal->getLocalizedName()|truncate:30:"…"}</span>
            </a>

            {* Desktop navigation links *}
            <ul class="nav-links" role="list">
                <li class="nav-link-item">
                    <a class="nav-link{if $requestedPage eq 'index'} active{/if}"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='index'}">
                        {translate key="navigation.homePage"}
                    </a>
                </li>
                <li class="nav-link-item">
                    <a class="nav-link{if $requestedPage eq 'issue'} active{/if}"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='archive'}">
                        {translate key="navigation.archives"}
                    </a>
                </li>
                <li class="nav-link-item">
                    <a class="nav-link{if $requestedPage eq 'about'} active{/if}"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about'}">
                        {translate key="navigation.about"}
                    </a>
                </li>
                <li class="nav-link-item">
                    <a class="nav-link{if $requestedPage eq 'search'} active{/if}"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='search'}">
                        {translate key="common.search"}
                    </a>
                </li>
                {if !$isUserLoggedIn}
                    <li class="nav-link-item">
                        <a class="nav-link"
                           href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login'}">
                            {translate key="user.login"}
                        </a>
                    </li>
                {/if}
            </ul>

            {* Right-side actions *}
            <div class="nav-actions">

                {* Locale / Language Switcher *}
                {if count($supportedLocales) > 1}
                <div class="locale-switcher" role="navigation"
                     aria-label="{translate key='plugins.themes.glassTheme.languageSwitcher'}">
                    <button class="locale-btn" id="locale-btn"
                            aria-haspopup="true" aria-expanded="false"
                            aria-controls="locale-dropdown">
                        <span aria-hidden="true">🌐</span>
                        <span>{$currentLocale|upper|truncate:2:""}</span>
                        <svg width="10" height="6" viewBox="0 0 10 6" fill="none" aria-hidden="true">
                            <path d="M1 1l4 4 4-4" stroke="currentColor" stroke-width="1.5"
                                  stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                    <div class="locale-dropdown" id="locale-dropdown" role="listbox">
                        {foreach from=$supportedLocales key=localeKey item=localeName}
                            <a class="locale-option{if $localeKey eq $currentLocale} current{/if}"
                               href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='user'
                                           op='setLocale' path=$localeKey
                                           source=$smarty.server.REQUEST_URI}"
                               data-locale="{$localeKey|escape}"
                               role="option"
                               aria-selected="{if $localeKey eq $currentLocale}true{else}false{/if}">
                                {if $localeKey eq 'en' || $localeKey eq 'en_US'}🇬🇧{/if}
                                {if $localeKey eq 'id' || $localeKey eq 'id_ID'}🇮🇩{/if}
                                {$localeName|escape}
                            </a>
                        {/foreach}
                    </div>
                </div>
                {/if}
 
                {* User Account Menu *}
                {if $isUserLoggedIn}
                <div class="user-menu" id="user-menu-root">
                    <button class="user-btn" id="user-btn" aria-haspopup="true" aria-expanded="false" aria-controls="user-dropdown">
                        <div class="user-avatar">
                            {assign var="userAvatar" value=$currentUser->getData('avatar')}
                            {if $userAvatar}
                                <img src="{$publicFilesDir}/{$userAvatar.uploadName|escape:"url"}" alt="{$currentUser->getFullName()|escape}">
                            {else}
                                <span>{$currentUser->getLocalizedGivenName()|substr:0:1|upper}{$currentUser->getLocalizedFamilyName()|substr:0:1|upper}</span>
                            {/if}
                        </div>
                        <span class="user-name">{$currentUser->getLocalizedGivenName()|escape}</span>
                        <svg width="10" height="6" viewBox="0 0 10 6" fill="none" aria-hidden="true" style="margin-left:2px;opacity:0.5;">
                            <path d="M1 1l4 4 4-4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                    <div class="user-dropdown" id="user-dropdown" role="menu">
                        <div class="user-dropdown-header">
                            <span class="name">{$currentUser->getFullName()|escape}</span>
                            <span class="email">{$currentUser->getEmail()|escape}</span>
                        </div>
                        <a class="user-dropdown-item" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='dashboard'}" role="menuitem">
                            <span>📊</span> {translate key="navigation.dashboard"}
                        </a>
                        <a class="user-dropdown-item" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='user' op='profile'}" role="menuitem">
                            <span>👤</span> {translate key="user.profile"}
                        </a>
                        <a class="user-dropdown-item" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='submission'}" role="menuitem">
                            <span>📝</span> {translate key="navigation.submissions"}
                        </a>
                        <div style="border-top:1px solid var(--glass-border);margin:0.5rem 0;"></div>
                        <a class="user-dropdown-item logout" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login' op='signOut'}" role="menuitem">
                            <span>🚪</span> {translate key="user.logOut"}
                        </a>
                    </div>
                </div>
                {/if}

                {* Submit/Login CTA *}
                {if $currentJournal->getData('allowPublicRegistration') || $isUserLoggedIn}
                    <a class="glass-btn glass-btn-primary"
                       href="{if $isUserLoggedIn}
                                  {url router=PKP\core\PKPApplication::ROUTE_PAGE page='submission'}
                              {else}
                                  {url router=PKP\core\PKPApplication::ROUTE_PAGE page='register'}
                              {/if}">
                        {if $isUserLoggedIn}
                            {translate key="author.submit"}
                        {else}
                            {translate key="user.register"}
                        {/if}
                    </a>
                {/if}

                {* Hamburger — mobile only *}
                <button class="nav-toggle" id="nav-toggle"
                        aria-controls="mobile-menu"
                        aria-expanded="false"
                        aria-label="{translate key='plugins.themes.glassTheme.openMenu'}">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
            </div>
        </div>

        {* Mobile full-screen menu *}
        <div class="mobile-menu" id="mobile-menu" role="dialog"
             aria-label="{translate key='common.navigation.site'}">
            <ul style="list-style:none;display:flex;flex-direction:column;gap:0.25rem;">
                {foreach from=[
                    ['page' => 'index',   'label' => 'navigation.homePage'],
                    ['page' => 'issue',   'label' => 'navigation.archives', 'op' => 'archive'],
                    ['page' => 'about',   'label' => 'navigation.about'],
                    ['page' => 'search',  'label' => 'common.search']
                ] item=item}
                <li>
                    <a class="nav-link"
                       style="display:block;padding:.75rem 1rem;border-radius:.5rem;"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE
                                   page=$item.page op=$item.op|default:''}">
                        {translate key=$item.label}
                    </a>
                </li>
                {/foreach}
                {if $isUserLoggedIn}
                <li style="margin-top:1rem;padding-top:1rem;border-top:1px solid var(--glass-border);">
                    <div style="display:flex;align-items:center;gap:0.75rem;padding:0.5rem 1rem;">
                        <div class="user-avatar" style="width:2.5rem;height:2.5rem;font-size:1rem;">
                             {assign var="userAvatar" value=$currentUser->getData('avatar')}
                             {if $userAvatar}
                                <img src="{$publicFilesDir}/{$userAvatar.uploadName|escape:"url"}" alt="{$currentUser->getFullName()|escape}">
                            {else}
                                <span>{$currentUser->getLocalizedGivenName()|substr:0:1|upper}{$currentUser->getLocalizedFamilyName()|substr:0:1|upper}</span>
                            {/if}
                        </div>
                        <div style="display:flex;flex-direction:column;">
                            <span style="font-weight:700;font-size:0.95rem;color:var(--glass-text);">{$currentUser->getFullName()|escape}</span>
                            <span style="font-size:0.75rem;color:var(--glass-text-subtle);">{$currentUser->getEmail()|escape}</span>
                        </div>
                    </div>
                </li>
                <li>
                    <a class="nav-link" style="display:block;padding:.75rem 1rem;border-radius:.5rem;" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='dashboard'}">
                        {translate key="navigation.dashboard"}
                    </a>
                </li>
                <li>
                    <a class="nav-link" style="display:block;padding:.75rem 1rem;border-radius:.5rem;" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='user' op='profile'}">
                        {translate key="user.profile"}
                    </a>
                </li>
                <li>
                    <a class="nav-link" style="display:block;padding:.75rem 1rem;border-radius:.5rem;color:#ef4444;" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login' op='signOut'}">
                        {translate key="user.logOut"}
                    </a>
                </li>
                {else}
                <li>
                    <a class="glass-btn glass-btn-primary" style="margin-top:.75rem;width:100%;justify-content:center;"
                       href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login'}">
                        {translate key="user.login"}
                    </a>
                </li>
                {/if}
            </ul>
        </div>
    </nav>

    <div class="pkp_structure_page">
