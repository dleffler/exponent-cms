<?php

##################################################
#
# Copyright (c) 2004-2006 OIC Group, Inc.
# Written and Designed by James Hunt
#
# This file is part of Exponent
#
# Exponent is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License as published by the Free
# Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# GPL: http://www.gnu.org/licenses/gpl.txt
#
##################################################

if (!defined('EXPONENT')) exit('');

/**
 * Autocomplete
 *
 * @author Phillip Ball
 * @copyright 2004-2010 OIC Group, Inc.
 * @version 2.0.0
 *
 * @package Subsystems
 * @subpackage Forms
 */

/**
 * Manually include the class file for formcontrol, for PHP4
 * (This does not adversely affect PHP5)
 */
require_once(BASE."subsystems/forms/controls/formcontrol.php");

/**
 * Popup Date/Time Picker Control
 *
 * @package Subsystems
 * @subpackage Forms
 */
class autocompletecontrol extends formcontrol {
    function name() { return "YAHOO! UI Autocomplete"; }
    function isSimpleControl() { return false; }

	function toHTML($label,$name) {
		$html = $this->controlToHTML($name, $label);
		return $html;
	}

    function controlToHTML($name,$label) {
    	$assets_path = SCRIPT_RELATIVE.'subsystems/forms/controls/assets/';
        $html = '<div class="text-control control exp-skin" id="search_stringControl">';
        $html .= empty($this->label) ? '' : '<label for="'.$name.'">'.$label.'</label>';
        $html .= '<input type="text" class="text " size="20" value="'.$this->value.'" name="'.$name.'" id="'.$name.'"/>
                <div id="results'.$name.'"></div>
            </div>
        ';
        
        $script = "
        YUI({ base:EXPONENT.YUI3_PATH,loadOptional: true}).use('node', function(Y) {

            Y.get('#".$name."').on('click',function(e){e.target.set('value','');});

            // autocomplete
            var autocomplete = function() {
                // Use an XHRDataSource
                var oDS = new YAHOO.util.XHRDataSource(EXPONENT.URL_FULL+\"index.php\");
                // Set the responseType
                oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;

                //oDS.responseType = YAHOO.util.XHRDataSource.TYPE_TEXT;
                // Define the schema of the delimited results
                oDS.responseSchema = {
                    resultsList : \"data\",
                    fields : [".$this->schema."]
                };

                // Enable caching
                oDS.maxCacheEntries = 5;

                // Instantiate the AutoComplete
                var oAC = new YAHOO.widget.AutoComplete(\"".$name."\", \"results".$name."\", oDS);
                oAC.generateRequest = function(sQuery) {
                    return \"?ajax_action=1&json=1&controller=".$this->controller."&model=".$this->searchmodel."&searchoncol=".$this->searchoncol."&action=".$this->action."&query=\"+sQuery ;
                };
                
                ".$this->jsinject."

            }();
        });
        "; // end JS
        
        // css
        expCSS::pushToHead(array(
    	    "unique"=>"ac0",
    	    "link"=>$assets_path."autocomplete/autocomplete.css"
    	    )
    	);
	
       
        exponent_javascript_toFoot('ac'.$name, "animation,autocomplete,connection,datasource", null, $script);
        return $html;
    }


}

?>
