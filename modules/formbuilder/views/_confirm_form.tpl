{*
 * Copyright (c) 2004-2006 OIC Group, Inc.
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


{if $recaptcha_theme !=""}
    {literal}
        <script>
        var RecaptchaOptions = {
           theme : {/literal}'{$recaptcha_theme}'{literal}
        };
        </script>
    {/literal}
{/if}

<div class="formbuilder confirm-form">
	<h1>Please confirm your submission</h1>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="exp-skin-table">
	    <thead>
        	<th>Field</th>
        	<th>Your Response</th>
        </thead>
        <tbody>
    	{foreach from=$responses item=response key=name}
    		<tr class="{cycle values="odd,even"}">
    			<td><strong>{$name}: </strong>
    			<td>{$response}</td>
    		</tr>
    	{/foreach}
		</tbody>
	</table>

	<p>If the information above looks correct, fill out the security question below to submit your form submission</p>
	{form action=submit_form}
		{foreach from=$postdata item=data key=name}
			{control type=hidden name=$name value=$data}
		{/foreach}
		{control type=antispam}
		{control type=buttongroup submit="Submit Form" cancel="Change Responses"}
	{/form}
	
</div> 
