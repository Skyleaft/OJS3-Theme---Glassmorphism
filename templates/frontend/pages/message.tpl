{**
 * @file templates/frontend/pages/message.tpl
 *
 * Glass Theme — System message page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="message-heading">
        <div class="hero-orb hero-orb-1" aria-hidden="true"
            style="width:300px;height:300px;top:-80px;left:10%;opacity:.6;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{$currentJournal->getLocalizedName()|escape}</span>
            <h1 class="section-title" id="message-heading" style="margin:.5rem 0 1.5rem;">
                {if $pageTitle}
                    {$pageTitle|escape}
                {elseif $pageTitleKey}
                    {capture assign="pageTitleLongKey"}{$pageTitleKey}.long{/capture}
                    {translate key=$pageTitleLongKey|default:$pageTitleKey}
                {else}
                    {translate key="common.message"}
                {/if}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="glass-card" style="padding: 2.5rem; max-width: 900px; margin: 0 auto;">
                <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.8;">
                    {if $messageKey}
                        {translate key=$messageKey}
                    {else}
                        {$message}
                    {/if}

                    {* Add navigation buttons for common registration messages *}
                    {if $messageKey == "user.login.registrationPendingValidation" || $pageTitleKey == "user.register.registrationPending"}
                        <div style="margin-top: 2.5rem; display: flex; gap: 1rem; flex-wrap: wrap;">
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="index"}" class="glass-btn glass-btn-primary">
                                {translate key="navigation.archives.continueBrowsing"}
                            </a>
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" class="glass-btn">
                                {translate key="user.login"}
                            </a>
                        </div>
                    {elseif $messageKey == "user.login.activated" || $pageTitleKey == "user.login.activated" || $pageTitleKey == "user.register.registrationConfirmed"}
                        <div style="margin-top: 2.5rem; display: flex; gap: 1rem; flex-wrap: wrap;">
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" class="glass-btn glass-btn-primary">
                                {translate key="user.login"}
                            </a>
                            <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="index"}" class="glass-btn">
                                {translate key="navigation.archives.continueBrowsing"}
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}