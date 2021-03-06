{*
 * Copyright (c) 2004-2008 OIC Group, Inc.
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

<div class="module blog showall">
    {if $moduletitle}<h1>{$moduletitle}</h1>{/if}

    {if $config.enable_rss == true}
        <a class="rsslink" href="{rsslink}">Subscribe to {$config.feed_title}</a>
    {/if}
    
    
    {permissions}
        {if $permissions.edit == 1}
            {icon class="add" action=edit title="Add a new blog article" text="Add a new blog article"}
      {/if}
    {/permissions}
    
    {$page->links}
    
    
    {foreach from=$page->records item=record}
        <div class="bodycopy">
            <h2>
            <a href="{link action=show title=$record->sef_url}">
            {$record->title}
            </a>
            </h2>
            {permissions}
                <div class="item-actions">
                    {if $permissions.edit == 1}
                        {icon action=edit img=edit.png class="editlink" id=$record->id title="Edit this `$modelname`"}
                    {/if}
                    {if $permissions.delete == 1}
                        {icon action=delete img=delete.png id=$record->id title="Delete this `$modelname`" onclick="return confirm('Are you sure you want to delete this `$modelname`?');"}
                    {/if}
                </div>
            {/permissions}
            <span class="post-info">Posted by {attribution user_id=$record->poster} on <span class="date">{$record->created_at|format_date:$smarty.const.DISPLAY_DATE_FORMAT}</span>
                <span class="tags">
                    Tags: 
                    {foreach from=$record->expTag item=tag name=tags}
                    <a href="{link action=showall_by_tags tag=$tag->sef_url}">{$tag->title}</a>
                    {if $smarty.foreach.tags.last != 1},{/if}
                    {/foreach} 
                </span>
            </span>
            {if $config.truncate}
                {$record->body|summarize:"html":"para"}
            {else}
                {$record->body}
            {/if}
            <div class="post-footer align-left">
                <a class="readmore" href="{link action=show title=$record->sef_url}">Read more</a> |
                {if $config.usescomments}
                    <a class="comments" href="{link action=show title=$record->sef_url}">Comments ({$record->expComment|@count})</a>
                {/if}
            </div>
        </div>
    {/foreach}    

    {$page->links}

</div>
