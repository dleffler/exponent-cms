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

<div class="module faq manage">
    <h1>Manage Questions</h1>
    <p>Here you can view questions on your site and edit, delete, and answer unanswered questions</p>
    
    {permissions}
        {if $permissions.edit == 1 && $page->records|@count>1}
            {ddrerank items=$page->records model="faq" sortfield="question" label="FAQs"}
        {/if}
        {if $permissions.create == 1}
            {icon class=add action=create title="Add a new FAQ" text="Add a New FAQ"}
        {/if}
    {/permissions}
    <table class="exp-skin-table">
    <thead>
        <tr>
            {$page->header_columns}
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$page->records item=question name=questions}
        <tr class="{cycle values="even, odd"}">
            <td>                
                {if $question->include_in_faq == 1}
                    <a href="{link action=edit_toggle id=$question->id}" title="Remove this question from the FAQs">
                        {img src=`$smarty.const.ICON_RELATIVE`toggle_on.gif}
                    </a>
                {else}
                    <a href="{link action=edit_toggle id=$question->id}" title="Add this question to the FAQs">
                        {img src=`$smarty.const.ICON_RELATIVE`toggle_off.gif}
                    </a>   
                {/if}                
            </td>
            <td>{if $question->answer != ""}{img src=`$smarty.const.ICON_RELATIVE`clean.png}{/if}</td> 
            <td>{$question->question}</td>
            <td>{$question->created_at|format_date:$smarty.const.DISPLAY_DATE_FORMAT}</td>
            <td>{$question->submitter_name}</td>
            <td>
                {permissions}
                    {if $permissions.edit == 1}
                        {icon img=edit.png action=edit id=$question->id title="Edit FAQ"}
                    {/if}
                    {if $permissions.delete == 1}
                        {icon action=delete img=delete.png id=$record->id title="Delete this FAQ?" onclick="return confirm('Are you sure you want to delete this FAQ?');"}
                    {/if}                  
                {/permissions}
            </td>
        </tr>
        {foreachelse}
        <tr><td>No questions found</td></tr>
        {/foreach}
    </tbody>
    </table>    
</div>

<a href="javascript: history.go(-1)">Go Back</a>
