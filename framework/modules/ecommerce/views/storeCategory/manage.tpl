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

{css unique="store-tree" corecss="tree"}

{/css}

<div class="storeCategory manage-categories">
	<div class="form_header">
			<h1>Manage Store Categories</h1>
			<p>This is where you can add, edit and rearrange categories.</p>
	</div>	
	{control type="tagtree" addable="true" id="managecats" name="managecats" controller=storeCategory draggable=true menu=true}
</div>



