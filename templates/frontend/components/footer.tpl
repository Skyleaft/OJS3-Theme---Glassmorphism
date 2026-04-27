{**
 * @file templates/frontend/components/footer.tpl
 *
 * Glass Theme — Dark glass footer
 *}

</div>{* .pkp_structure_page *}

<footer class="site-footer" role="contentinfo">
    <div class="footer-grid">

        {* Brand column *}
        <div>
            <div class="footer-brand-name">{$currentJournal->getLocalizedName()|escape}</div>
            <p class="footer-brand-desc">
                {$currentJournal->getLocalizedDescription()|strip_tags|truncate:160:"…"|escape}
            </p>

            {* ISSN *}
            {assign var="pIssn" value=$currentJournal->getData('printIssn')}
            {assign var="eIssn" value=$currentJournal->getData('onlineIssn')}
            {if $pIssn || $eIssn}
                <div style="margin-top:1.25rem;display:flex;flex-direction:column;gap:.35rem;">
                    {if $pIssn}
                        <span style="font-size:.75rem;color:#64748b;">
                            {translate key="journal.pIssn"}: <strong style="color:#94a3b8;">{$pIssn|escape}</strong>
                        </span>
                    {/if}
                    {if $eIssn}
                        <span style="font-size:.75rem;color:#64748b;">
                            {translate key="journal.eIssn"}: <strong style="color:#94a3b8;">{$eIssn|escape}</strong>
                        </span>
                    {/if}
                </div>
            {/if}
        </div>

        {* Navigation column *}
        <div>
            <div class="footer-col-title">{translate key="navigation.site"}</div>
            <ul class="footer-links">
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='index'}">{translate key="navigation.homePage"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='issue' op='archive'}">{translate key="navigation.archives"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='search'}">{translate key="common.search"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about'}">{translate key="navigation.about"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about' op='submissions'}">{translate key="about.submissions"}</a>
                </li>
            </ul>
        </div>

        {* About column *}
        <div>
            <div class="footer-col-title">{translate key="about.aboutTheJournal"}</div>
            <ul class="footer-links">
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about'}">{translate key="about.editorialTeam"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about' op='contact'}">{translate key="about.contact"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='about' op='privacy'}">{translate key="about.privacyStatement"}</a>
                </li>
            </ul>
        </div>

        {* Information column *}
        <div>
            <div class="footer-col-title">{translate key="common.information"}</div>
            <ul class="footer-links">
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='information' op='readers'}">{translate key="navigation.infoForReaders"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='information' op='authors'}">{translate key="navigation.infoForAuthors"}</a>
                </li>
                <li><a
                        href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='information' op='librarians'}">{translate key="navigation.infoForLibrarians"}</a>
                </li>
            </ul>
        </div>

        {* Account column *}
        <div>
            <div class="footer-col-title">{translate key="navigation.access"}</div>
            <ul class="footer-links">
                {if $isUserLoggedIn}
                    <li><a
                            href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='user' op='profile'}">{translate key="user.profile"}</a>
                    </li>
                    <li><a
                            href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='submission'}">{translate key="author.submit"}</a>
                    </li>
                    <li><a
                            href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login' op='signOut'}">{translate key="user.logOut"}</a>
                    </li>
                {else}
                    <li><a
                            href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='login'}">{translate key="user.login"}</a>
                    </li>
                    <li><a
                            href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page='user' op='register'}">{translate key="user.register"}</a>
                    </li>
                {/if}
            </ul>
        </div>
    </div>

    <div class="footer-bottom">
        <span>
            &copy; {$smarty.now|date_format:"%Y"}
            {$currentJournal->getLocalizedName()|escape}.
            {translate key="common.copyright"}.
        </span>
        <span style="display:flex;align-items:center;gap:.5rem;">
            {translate key="common.publishedWith"}
            <a href="https://pkp.sfu.ca/ojs/" target="_blank" rel="noopener noreferrer"
                style="color:#6366f1;text-decoration:none;font-weight:600;">OJS</a>
        </span>
    </div>
</footer>

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>

</html>