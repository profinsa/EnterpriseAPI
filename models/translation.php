<?php
/*
Name of Page: Translation

Method: Translation model, used for translation ui items

Date created: Nikita Zaharov, 09.02.2016

Use: translationg used by all page controllers for translating purpose

Input parameters:
$db: database instance
$language: language to translate to

Output parameters:
$translation: model, it is responsible for translation in view

Called from:
+ most controllers from /controllers

Calls:
sql

Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/

class translation{
    protected $terms = array();
    
    public $lang = "English";
    //list of available languages
    public $languages = [
        "English",
        "Dutch",
        "French",
        "Fund",
        "German",
        "Arabic",
        "ChineseSimple",
        "ChineseTrad",
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

    //model constructor, just load all words for a certain language
    public function __construct($db, $language){
        $this->lang = $language;
        $result = mysqli_query($db, "SELECT ObjID,ObjDescription," . $language . ",Translated from translation") or die('mysql query error: ' . mysqli_error($db));

        while ($row = mysqli_fetch_assoc($result)) {
            $this->terms[$row["ObjID"]] = $row;
        }
    }

    //translate term(label) to language with whic model is initialized
    public function translateLabel($label){
        //      echo $label . $this->terms[$label]["Translated"] . $this->lang;
        if(key_exists($label, $this->terms) && $this->terms[$label]["Translated"])
            return $this->terms[$label][$this->lang];
        else
            return $label;
    }
}
?>