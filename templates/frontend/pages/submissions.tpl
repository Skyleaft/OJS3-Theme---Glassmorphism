{**
 * @file templates/frontend/pages/submissions.tpl
 *
 * Glass Theme — Submissions page
 *}

{include file="frontend/components/header.tpl"}

<main id="main-content" class="page-fade">

    {* ── Submissions Hero ─────────────────────────────────────────────────── *}
    <section class="search-hero" aria-labelledby="submissions-heading">
        <div class="hero-orb hero-orb-2" aria-hidden="true"
            style="width:300px;height:300px;bottom:-60px;left:15%;opacity:.5;"></div>

        <div style="position:relative;z-index:1;">
            <span class="section-eyebrow">{translate key="about.aboutTheJournal"}</span>
            <h1 class="section-title" id="submissions-heading" style="margin:.5rem 0 1.5rem;">
                {translate key="about.submissions"}
            </h1>
        </div>
    </section>

    <section class="section" style="padding-top: 0;">
        <div class="page-container">

            {* 1. Online Submissions Action *}
            <div class="glass-card"
                style="padding: 2.5rem; margin-bottom: 2rem; border-left: 4px solid var(--color-accent);">
                <div
                    style="display: flex; align-items: center; justify-content: space-between; gap: 2rem; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 300px;">
                        <h2 class="sidebar-title"
                            style="margin-bottom: .75rem; color: var(--glass-text); font-size: 1.1rem;">
                            {translate key="about.onlineSubmissions"}
                        </h2>
                        <p style="color: var(--glass-text-muted); font-size: .9rem;">
                            {translate key="about.onlineSubmissions.registrationRequired"}
                        </p>
                    </div>
                    <div style="display: flex; gap: .75rem;">
                        <a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='submission' op='wizard'}"
                            class="glass-btn glass-btn-primary">
                            {translate key="about.onlineSubmissions.submitPost"}
                        </a>
                        <a href="{url page="user" op="register" source=$source}" class="glass-btn glass-btn-ghost">
                            {translate key="about.onlineSubmissions.registration"}
                        </a>
                    </div>
                </div>
            </div>

            <div class="article-layout" style="padding-top: 0;">
                <div class="article-main">

                    {* 2. Author Guidelines *}
                    {if $authorGuidelines}
                        <div class="glass-card" style="padding: 2rem; margin-bottom: 2rem;">
                            <h2 class="sidebar-title"
                                style="margin-bottom: 1.5rem; display: flex; align-items: center; gap: .75rem;">
                                <span
                                    style="background: var(--color-accent); width: 24px; height: 24px; border-radius: 6px; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: .7rem;">1</span>
                                {translate key="about.authorGuidelines"}
                            </h2>
                            <div class="article-content" style="color: var(--glass-text-muted); line-height: 1.7;">
                                {$authorGuidelines}
                            </div>
                        </div>
                    {/if}

                    {* 3. Submission Checklist *}
                    {if $submissionChecklist}
                        <div class="glass-card" style="padding: 2rem; margin-bottom: 2rem;">
                            <h2 class="sidebar-title"
                                style="margin-bottom: 1.5rem; display: flex; align-items: center; gap: .75rem;">
                                <span
                                    style="background: var(--color-accent); width: 24px; height: 24px; border-radius: 6px; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: .7rem;">2</span>
                                {translate key="about.submissionPreparationChecklist"}
                            </h2>
                            <div style="color: var(--glass-text-muted); line-height: 1.7;">
                                <p style="margin-bottom: 1rem; font-size: .875rem;">
                                    {translate key="about.submissionPreparationChecklist.description"}</p>
                                <ul style="list-style: none; display: flex; flex-direction: column; gap: 1rem;">
                                    {foreach from=$submissionChecklist item=checkItem}
                                        <li
                                            style="display: flex; gap: 1rem; background: rgba(255,255,255,0.03); padding: 1rem; border-radius: .75rem; border: 1px solid var(--glass-border);">
                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                                style="flex-shrink: 0; color: var(--color-accent-light); margin-top: 2px;">
                                                <rect width="20" height="20" rx="6" fill="currentColor" fill-opacity="0.1" />
                                                <path d="M6 10l3 3 5-5" stroke="currentColor" stroke-width="2"
                                                    stroke-linecap="round" stroke-linejoin="round" />
                                            </svg>
                                            <span style="font-size: .9rem;">
                                                {if $checkItem|is_array}
                                                    {$checkItem.content}
                                                {else}
                                                    {$checkItem}
                                                {/if}
                                            </span>
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                    {/if}

                    {* 4. Privacy Statement *}
                    {if $privacyStatement}
                        <div class="glass-card" style="padding: 2rem;">
                            <h2 class="sidebar-title"
                                style="margin-bottom: 1.5rem; display: flex; align-items: center; gap: .75rem;">
                                <span
                                    style="background: var(--color-accent); width: 24px; height: 24px; border-radius: 6px; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: .7rem;">3</span>
                                {translate key="about.privacyStatement"}
                            </h2>
                            <div class="article-content"
                                style="color: var(--glass-text-muted); font-size: .875rem; line-height: 1.7;">
                                {$privacyStatement}
                            </div>
                        </div>
                    {/if}
                </div>

                {* Sidebar: Quick stats/info *}
                <aside class="article-sidebar">
                    <div class="glass-card" style="padding: 1.5rem;">
                        <h3 class="sidebar-title">{translate key="plugins.themes.glassTheme.journalInfo"}</h3>
                        <div style="margin-top: 1rem; display: flex; flex-direction: column; gap: .75rem;">
                            <div
                                style="padding: .75rem; background: rgba(255,255,255,0.03); border-radius: .5rem; border: 1px solid var(--glass-border);">
                                <div
                                    style="font-size: .7rem; color: var(--glass-text-subtle); text-transform: uppercase;">
                                    {translate key="journal.pIssn"}</div>
                                <div style="font-size: .9rem; font-weight: 600;">
                                    {$currentJournal->getData('printIssn')|escape}</div>
                            </div>
                            <div
                                style="padding: .75rem; background: rgba(255,255,255,0.03); border-radius: .5rem; border: 1px solid var(--glass-border);">
                                <div
                                    style="font-size: .7rem; color: var(--glass-text-subtle); text-transform: uppercase;">
                                    {translate key="journal.eIssn"}</div>
                                <div style="font-size: .9rem; font-weight: 600;">
                                    {$currentJournal->getData('onlineIssn')|escape}</div>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </section>

</main>

{include file="frontend/components/footer.tpl"}