{*
 * Copyright (c) 2007-2008 OIC Group, Inc.
 * Written and Designed by Adam Kessler
 *
 * This file is part of Exponent
 *
 * Exponent is free software; you can redistribute
 * it and/or modify it under the terms of the GNU
 * General Public License as published by the Free
 * Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * GPL: http://www.gnu.org/licenses/gpl.txt
 *
 *}

<div class="module users manage-extensions">
	<h1>{"Manage User Profile Extensions"|gettext}</h1>	
	<p>
        {"From here activate or deactivate user profile extensions.  User profile extensions are used to 
        give users the ability to put in more information about themselves.  The active extensions will 
        add fields to the form a user has to fill out to create an account."|gettext}
    </p>

	{$page->links}
	<table class="exp-skin-table">
	    <thead>
		<tr>
		    {$page->header_columns}
		</tr>
		</thead>
		<tbody>
			{foreach from=$page->records item=listing name=listings}
			<tr class="{cycle values="odd,even"}">
				<td>{$listing->title}</td>
				<td>{$listing->body}</td>
				<td>
                    {if $listing->active}
                        <a href="{link action=toggle_extension id=$listing->id}">{img src=`$smarty.const.ICON_RELATIVE`toggle_on.gif}</a>
                    {else}
                        <a href="{link action=toggle_extension id=$listing->id}">{img src=`$smarty.const.ICON_RELATIVE`toggle_off.gif}</a>
                    {/if}
				</td>
			</tr>
			{foreachelse}
			    <td colspan="{$page->columns|count}">No Data.</td>
			{/foreach}
		</tbody>
		</table>
		{$page->links}
</div>
