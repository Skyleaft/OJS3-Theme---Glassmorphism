{**
 * @file templates/frontend/components/breadcrumbs.tpl
 *
 * Glass Theme — Sticky frosted-glass breadcrumb bar
 *}

{if $breadcrumbs && $breadcrumbs|@count > 1}
    <nav class="breadcrumbs-bar" aria-label="{translate key='navigation.breadcrumb'}">
        <ol class="breadcrumbs">
            {foreach from=$breadcrumbs item=crumb name=loop}
                <li class="breadcrumb-item{if $smarty.foreach.loop.last} active{/if}"
                    {if $smarty.foreach.loop.last}aria-current="page" {/if}>

                    {if not $smarty.foreach.loop.first}
                        <svg class="breadcrumb-separator" width="6" height="10" viewBox="0 0 6 10" fill="none" aria-hidden="true">
                            <path d="M1 1l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                    {/if}

                    {if $smarty.foreach.loop.last}
                        <span>{$crumb.name|escape}</span>
                    {else}
                        <a href="{$crumb.url|escape}">{$crumb.name|escape}</a>
                    {/if}
                </li>
            {/foreach}
        </ol>
    </nav>
{/if}