/*
 * Copyright (c) 2004-2006 OIC Group, Inc.
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
 */

function alphanum_filter_class() {
	
	this.on_key_press = function(ptObject, evt) {
		//This will allow backspace to work.
		evt = (evt) ? evt : event;
		sChar = (evt.charCode) ? evt.charCode : evt.keyCode;
		for (var n =0; n < g_aIgnore.length; n++) {
			if (sChar == g_aIgnore[n]) return true;
		}
				console.debug(sChar);
		var strNewVal = GetResultingValue(ptObject, String.fromCharCode(sChar));
		
		if (this.isValueIllegal(strNewVal)) {
			return false;
		}
		return true;
	}
	
	this.onblur = function(ptObject) {
		//Do nothing for integer
	}
	
	this.onfocus = function(ptObject) {
		//Do nothing for integer
	}
	
	this.onpaste = function(ptObject, evt) {
		var strNewVal = GetResultingValue(ptObject, String.fromCharCode(evt.charCode));
		alert(strNewVal);
		if (this.isValueIllegal(strNewVal)) {
			return false;
		}
		return true;
	}
	
	this.isValueIllegal = function(strValue) {
	    //console.debug(strValue);
	    var regex=/^[0-9A-Za-z]+$/; //^[a-zA-z]+$/
        if(regex.test(strValue)){
            //console.debug(strValue + ' is good');
            return false;
        } else {
            //console.debug(strValue + ' is bad');
            return true;
        }
	}
}

var alphanum_filter = new alphanum_filter_class();
