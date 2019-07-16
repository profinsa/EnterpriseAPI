<?php
/*
  Name of Page: liksMaker model

  Method: It makes links to any page of project by properties

  Date created: Nikita Zaharov, 05.24.2017

  Use: this model used for 
  For creating links to pages of projects using properties as source. 
  Model expose identical api in EnterpriseX. Because of it, views uses same code to generate 
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

  Last Modified: 17.04.2019
  Last Modified by: Nikita Zaharov
*/

class linksMaker{
    protected $accounts = null;
    function makeGridItemSave($path){
        return "index.php?page=grid&action=$path&update=true";
    }

    function makeGridItemNew($path){
        return "index.php?page=grid&action=$path&new=true";
    }

    function makeGridItemNewPartial($path){
        return "index.php#/?page=grid&action=$path&mode=new";
    }    

    function makeGridItemView($path, $item){
        return "index.php#/?page=grid&action=$path&mode=view&category=Main&item=$item";
    }

    public function makeGridItemViewWithBackPath($path, $item, $backpath, $backitem){
        return "index.php#/?page=grid&action=$path&mode=view&category=Main&item=" . urlencode($item);
        //FIXME need implement backlink mechanics
        // . "&back=index.php.../?page=grid&action=$path&mode=view&category=Main&item={$this->prefix}/index.../grid/$backpath/grid/Main/$backitem";
    }

    function makeGridItemEdit($path, $item){
        return "index.php#/?page=grid&action=$path&mode=edit&category=Main&item=$item";
    }

    function makeGridItemViewCancel($path){
        return $this->makeGridLink($path);
    }
    
    public function makeGridLink($path){
        return "index.php#/?page=grid&action=$path&mode=grid&category=Main&item=all";
    }

    public function makeGridLinkWithItem($path, $item){
        return "index.php#/?page=grid&action=$path&mode=grid&cagegory=Main&item=" . urlencode($item);
    }
    
	function makeEmbeddedviewItemViewLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=view&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=grid&category=Main&item=$item");
	}

	function makeEmbeddedgridItemNewLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=new&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=view&category=Main&item=$item");
	}
	public function makeEmbeddedgridItemViewLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=view&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=view&category=Main&item=$item");
	}

	public function makeEmbeddedgridItemEditLink($viewpath, $backpath, $keyString, $item){
	    return "index.php#/?page=grid&action=$viewpath&mode=edit&category=Main&item=$keyString&back=" . urlencode("index.php#/?page=grid&action=$backpath&mode=view&category=Main&item=$item");
	}

    function makeEmbeddedgridItemDeleteLink($path, $item){
        return "index.php?page=grid&action=$path&procedure=detailDelete&item=$item";
    }

    function makeProcedureLink($path, $procedure){
        return "index.php?page=grid&action=$path&procedure=$procedure";
    }

    function makeDashboardLink(){
        return "index.php#/?page=dashboard";
    }

    function makeDocreportsLink($type, $id){
        return "index.php?page=docreports&type=$type&id=$id"; 
    }

    function makeAutoreportsViewLink($type, $name, $id, $title, $options){
        return "index.php?page=autoreports&getreport=$name&type=$type&title=$title&$options";
    }

    function makeImageLink($name, $item, $itemDesc){
        $imageLink = "";
        
        if($name && file_exists("./uploads/$name"))
           $imageLink = "uploads/$name";
        else if(key_exists("urlField", $itemDesc) &&
                $item[$itemDesc["urlField"]] &&
                file_exists("./assets/images/" . $item[$itemDesc["urlField"]]))
            $imageLink = "assets/images/" . $item[$itemDesc["urlField"]];
        else
           $imageLink = "assets/images/notfound.png";
        
        return $imageLink;
    }
}