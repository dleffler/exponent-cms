{*
 * Copyright (c) 2004-2011 OIC Group, Inc.
 * Written and Designed by James Hunt
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
 
{css unique="cal" link="`$smarty.const.PATH_RELATIVE`modules/calendarmodule/assets/css/calendar.css"}

{/css}

<div class="module calendar default"> 
	<div class="module-actions">
		<a class="monthviewlink" href="{link action=viewmonth time=$startweek}" title="{$_TR.alt_view_month}">{$_TR.view_month}</a>
		&nbsp;&nbsp;|&nbsp;&nbsp;{printer_friendly_link class="printer-friendly-link" text=$_TR.printer_friendly}
	</div>
	<h2>
		{if $enable_ical == true}
			<a class="icallink module-actions" href="{link action=ical}" title="{$_TR.alt_ical}" alt="{$_TR.alt_ical}">{$_TR.ical}</a>
		{/if}
		{if $moduletitle != ""}{$moduletitle}{/if}
	</h2>
	{permissions}
		<div class="module-actions">
			{if $permissions.post == 1}
				<a class="add" href="{link action=edit id=0}" title={"Create Event"|gettext}>{"Create Event"|gettext}</a>
			{/if}
		</div>
	{/permissions}
	<p class="caption">
		<a class="module-actions calendar_mngmntlink" href="{link action=viewweek time=$startprevweek2}" title="{$_TR.view_week} {$startprevweek2|format_date:"%B %e, %Y"}">{$startprevweek2|format_date:"%b %e"}</a>&nbsp;&nbsp;&laquo;&nbsp;
		<a class="module-actions calendar_mngmntlink" href="{link action=viewweek time=$startprevweek}" title="{$_TR.view_week} {$startprevweek|format_date:"%B %e, %Y"}">{$startprevweek|format_date:"%b %e"}</a>&nbsp;&nbsp;&laquo;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span>{$_TR.view_week} {$startweek|format_date:"%B %e, %Y"}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;&nbsp;
		<a class="module-actions calendar_mngmntlink" href="{link action=viewweek time=$startnextweek}" title="{$_TR.view_week} {$startnextweek|format_date:"%B %e, %Y"}">{$startnextweek|format_date:"%b %e"}</a>&nbsp;&nbsp;&raquo;&nbsp;
		<a class="module-actions calendar_mngmntlink" href="{link action=viewweek time=$startnextweek2}" title="{$_TR.view_week} {$startnextweek2|format_date:"%B %e, %Y"}">{$startnextweek2|format_date:"%b %e"}</a>
	</p>
	<dl class="viewweek">

		{foreach from=$days item=events key=ts}
			<dt>
				<strong>
				{if $counts[$ts] != 0}
					<a class="itemtitle calendar_mngmntlink" href="{link action=viewday time=$ts}">{$ts|format_date:"%A, %b %e"}</a>
				{else}
					{$ts|format_date:"%A, %b %e"}
				{/if}
				</strong>
			</dt>
			{assign var=none value=1}
			{foreach from=$events item=event}
				{assign var=none value=0}
				<dd>
					<a class="itemtitle calendar_mngmntlink" href="{link action=view id=$event->id date_id=$event->eventdate->id}" title="{$event->body|summarize:"html":"para"}">{$event->title}</a>
					{permissions level=$smarty.const.UILEVEL_PERMISSIONS}
						<div class="item-actions">
							{if $permissions.edit == 1}
								<a href="{link action=edit id=$event->id date_id=$event->eventdate->id}"><img class="mngmnt_icon" src="{$smarty.const.ICON_RELATIVE}edit.png" title="{$_TR.alt_edit}" alt="{$_TR.alt_edit}" /></a>&nbsp;
							{/if}
							{if $permissions.delete == 1}
								{if $event->is_recurring == 0}
									<a href="{link action=delete id=$event->id}" onclick="return confirm('{$_TR.delete_confirm}');"><img class="mngmnt_icon" src="{$smarty.const.ICON_RELATIVE}delete.png" title="{$_TR.alt_delete}" alt="{$_TR.alt_delete}" /></a>
								{else}
									<a href="{link action=delete_form date_id=$event->eventdate->id id=$event->id}"><img class="mngmnt_icon" src="{$smarty.const.ICON_RELATIVE}delete.png" title="{$_TR.alt_delete}" alt="{$_TR.alt_delete}" /></a>
								{/if}
							{/if}
						</div>
					{/permissions}
					<div>
						{if $event->is_allday == 1}- All Day{else}
							{if $event->eventstart != $event->eventend}
								- {$event->eventstart|format_date:$smarty.const.DISPLAY_TIME_FORMAT} to {$event->eventend|format_date:$smarty.const.DISPLAY_TIME_FORMAT}
							{else}
								- {$event->eventstart|format_date:$smarty.const.DISPLAY_TIME_FORMAT}
							{/if}
						{/if}
						{br}
						{$event->summary}
					</div>
				</dd>
			{/foreach}
			{if $none == 1}
				<dd><em>{$_TR.no_events}</em></dd>
			{/if}
		{/foreach}
	</dl>
</div>