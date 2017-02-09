<?php
class translation{
    protected $terms = array();
    protected $lang = "english";
    
    public function __construct($language){
        $this->lang = $language;
        $result = mysql_query("SELECT ObjID,ObjDescription," . $language . ",Translated from translation") or die('mysql query error: ' . mysql_error());

        while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
            $this->terms[$row["ObjID"]] = $row;
        }            
        mysql_free_result($result);
    }

    public function translateLabel($label){
        //      echo $label . $this->terms[$label]["Translated"] . $this->lang;
        if(key_exists($label, $this->terms) && $this->terms[$label]["Translated"])
            return $this->terms[$label][$this->lang] . $this->lang;
        else
            return $label;
    }
}
?>