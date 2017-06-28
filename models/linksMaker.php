<?php
/*
Name of Page: liksMaker model

Method: It makes links to any page of project by properties

Date created: Nikita Zaharov, 05.24.2016

Use: this model used for 
For creating links to pages of projects using properties as source. 
Model expose identical api in both projects(NewTechPhp and Enterprise). Because of it, views uses same code to generate 
different links in interface. This increases the speed of porting features.

Input parameters:
$capsule: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
any views

Calls:
sql

Last Modified: 05.24.2016
Last Modified by: Nikita Zaharov
*/

class linksMaker{
    protected $accounts = null;
    function makeGridItemSave($path){
        return "index.php?page=grid&action=$path&update=true";
    }

    function makeGridItemNew($path){
        return "index.php#/?page=grid&action=$path&new=true";
    }

    function makeGridItemView($path, $item){
        return "index.php#/?page=grid&action=$path&mode=view&category=Main&item=$item";
    }

    function makeGridItemEdit($path, $item){
        return "index.php#/?page=grid&action=$path&mode=edit&category=Main&item=$item";
    }

    function makeGridItemViewCancel($path){
        return "index.php#/?page=grid&action=$path&mode=grid&category=Main&item=all";
    }
    
	function makeEmbeddedgridItemViewLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=view&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=view&category=Main&item=$item");
	}

	function makeEmbeddedviewItemViewLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=view&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=grid&category=Main&item=$item");
	}

	function makeEmbeddedgridItemNewLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=new&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=view&category=Main&item=$item");
	}

    function makeEmbeddedgridItemDeleteLink($path, $item){
        return "index.php?page=grid&action=$path&procedure=detailDelete&item=$item";
    }
}