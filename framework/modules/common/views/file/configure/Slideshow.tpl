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
 
<h2>Slideshow Configuration</h2>
{control type=text name="width" label="Slideshow Width" value=$config.width|default:350 size="5"}
{control type=text name="height" label="Slideshow Height" value=$config.height|default:200 size="5"}
{control type=text name="speed" label="Seconds per slide" value=$config.speed|default:5 size="5"}
{control type=text name="quality" label="JPEG Quality (0 - 100)<br><small>If quality is set to 100, the raw image will be used instead of thumbnailing</small>" value=$config.quality|default:80 size="5"}


