{**
 * @file templates/frontend/pages/contact.tpl
 *
 * Glass Theme — Contact page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    <section class="search-hero" aria-labelledby="contact-heading">
        <div class="hero-orb hero-orb-2" aria-hidden="true"
            style="width:300px;height:300px;top:-80px;right:10%;opacity:.6;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="about.contact"}</span>
            <h1 class="section-title" id="contact-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="about.contact"}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">
            <div class="card-grid" style="grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));">

                {* Primary Contact *}
                {if $contactName || $contactEmail}
                    <div class="glass-card" style="padding: 2rem;">
                        <h2 class="sidebar-title" style="margin-bottom: 1.5rem;">
                            {translate key="about.contact.principalContact"}
                        </h2>
                        <div style="display: flex; flex-direction: column; gap: 1rem; color: var(--glass-text-muted);">
                            {if $contactName}
                                <div>
                                    <div style="font-size: .75rem; color: var(--color-accent-light); font-weight: 700;">
                                        {translate key="user.name"}</div>
                                    <div style="font-size: 1.1rem; color: var(--glass-text); font-weight: 600;">
                                        {$contactName|escape}</div>
                                </div>
                            {/if}
                            {if $contactTitle}
                                <div>
                                    <div style="font-size: .75rem; color: var(--color-accent-light); font-weight: 700;">
                                        {translate key="user.title"}</div>
                                    <div>{$contactTitle|escape}</div>
                                </div>
                            {/if}
                            {if $contactAffiliation}
                                <div>
                                    <div style="font-size: .75rem; color: var(--color-accent-light); font-weight: 700;">
                                        {translate key="user.affiliation"}</div>
                                    <div>{$contactAffiliation|strip_tags}</div>
                                </div>
                            {/if}
                            {if $contactEmail}
                                <div style="margin-top: .5rem;">
                                    <a href="mailto:{$contactEmail|escape}" class="glass-btn glass-btn-primary"
                                        style="width: 100%; justify-content: center;">
                                        {translate key="about.contact.email"}
                                    </a>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}

                {* Technical Contact *}
                {if $supportName || $supportEmail}
                    <div class="glass-card" style="padding: 2rem;">
                        <h2 class="sidebar-title" style="margin-bottom: 1.5rem;">
                            {translate key="about.contact.supportContact"}
                        </h2>
                        <div style="display: flex; flex-direction: column; gap: 1rem; color: var(--glass-text-muted);">
                            {if $supportName}
                                <div>
                                    <div style="font-size: .75rem; color: var(--color-accent-light); font-weight: 700;">
                                        {translate key="user.name"}</div>
                                    <div style="font-size: 1.1rem; color: var(--glass-text); font-weight: 600;">
                                        {$supportName|escape}</div>
                                </div>
                            {/if}
                            {if $supportEmail}
                                <div style="margin-top: .5rem;">
                                    <a href="mailto:{$supportEmail|escape}" class="glass-btn glass-btn-ghost"
                                        style="width: 100%; justify-content: center;">
                                        {translate key="about.contact.email"}
                                    </a>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>

            {if $mailingAddress}
                <div class="glass-card" style="padding: 2.5rem; margin-top: 2rem;">
                    <h2 class="sidebar-title" style="margin-bottom: 1.5rem;">{translate key="common.mailingAddress"}</h2>
                    <div style="color: var(--glass-text-muted); line-height: 1.8;">
                        {$mailingAddress|nl2br}
                    </div>
                </div>
            {/if}
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}