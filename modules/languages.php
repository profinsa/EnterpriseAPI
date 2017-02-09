<?php
class languages{
    public $list = [
        "english" => "english",
        "russian" => "русский"
    ];

    protected $terms = [
        "english" => [
            "log in" => "log in",
            "log out" => "log out"
        ],
        "russian" => [
            "log in" => "войти",
            "log out" => "выйти"
        ]
    ];
    
    public function translate($term, $lang){
        return $this->terms[$lang][$term];
    }
}
?>