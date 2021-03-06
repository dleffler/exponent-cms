<?php
/**
 *  This file is part of Exponent
 *  Exponent is free software; you can redistribute
 *  it and/or modify it under the terms of the GNU
 *  General Public License as published by the Free
 *  Software Foundation; either version 2 of the
 *  License, or (at your option) any later version.
 *
 * The file thats holds the expSimpleNote class
 *
 * @link http://www.gnu.org/licenses/gpl.txt GPL http://www.gnu.org/licenses/gpl.txt
 * @package Exponent-CMS
 * @copyright 2004-2006 OIC Group, Inc.
 * @author Jonathan Worent <jonathan@oicgroup.net>
 * @version 2.0.0
 */
/**
 * This is the class expSimpleNote
 *
 * @subpackage Core-Datatypes
 * @package Framework
 */

class expSimpleNote extends expRecord {
    public $table = 'expSimpleNote';
    public $attachable_table = 'content_expSimpleNote';
    protected $attachable_item_types = array(
        //'content_expFiles'=>'expFile', 
        //'content_expTags'=>'expTag', 
        //'content_expComments'=>'expComment',
        //'content_expSimpleNote'=>'expSimpleNote',
    );
    
}
?> 
