<?php
class translation{
    protected $terms = array();
    protected $lang = "english";
    
    public $languages = [
        "Arabic",
        "ChineseSimple",
        "ChineseTrad",
        "Dutch",
        "English",
        "French",
        "Fund",
        "German",
        "Hindi",
        "Italian",
        "Japanese",
        "Korean",
        "Portuguese",
        "Russian",
        "Spanish",
        "Swedish",
        "Thai"
    ];
    
    public function __construct($db, $language){
        $this->lang = $language;
        $result = mysqli_query($db, "SELECT ObjID,ObjDescription," . $language . ",Translated from translation") or die('mysql query error: ' . mysqli_error($db));

        while ($row = mysqli_fetch_assoc($result)) {
            $this->terms[$row["ObjID"]] = $row;
        }            
        mysqli_free_result($result);
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