{*
 * Copyright (c) 2004-2011 OIC Group, Inc.
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

<div class="module migration manage_content">
    <h1>Migrate Content</h1>
    <p> 
        The following is a list of modules we found in the database {$config.database}.
    </p>
    
    {form action="migrate_content"}
        <table class="exp-skin-table">
        <thead>
            <tr>
                <th>Migrate</th>
                <th>Replace</th>
                <th>Module</th>
                <th>Count</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        {foreach from=$modules item=module name=modules}
        {if !$module->notmigrating}
        <tr class="{cycle values="even,odd"}">            
            <td>
                <input type=checkbox name="migrate[{$module->module}]" label=" " value=1 checked=1>
            </td>
            <td>
                <input type=checkbox name="replace[{$module->module}]" label=" " value=1>
            </td>
            <td>
                {$module->module}
            </td>
            <td>
                {$module->count}
            </td>
            <td>{$module->action}</td>
        </tr>
        {/if}
        {foreachelse}
                <tr><td colspan=2>No modules found in the database {$config.database}</td></tr>
        {/foreach}
        </tbody>
        </table>
        {control type="checkbox" name="wipe_content" label="Erase all current content before import?" value=1 checked=false}
        {control type="buttongroup" submit="Migrate Content" cancel="Cancel"}
    {/form}
</div>