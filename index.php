<?php
require 'vendor/autoload.php';

function db_start(){
    $link = mysql_connect('localhost', 'root', 'dataB00m')
          or die('database error: ' . mysql_error());
    //echo 'Соединение успешно установлено';
    mysql_select_db('integralx') or die('Не удалось выбрать базу данных');

    return $link;
}
function db_end($link){
    mysql_close($link);    
}
class app{
    public $scope = [];
    public $title = 'Integral Accounting X';
    public $page = 'main';
    public $renderUi = true;
    public function __construct(){
       if ($_SERVER['REQUEST_METHOD'] === 'POST') {
           if(isset($_POST["page"]))
               $this->page = $_POST["page"];
       }else if($_SERVER['REQUEST_METHOD'] === 'GET'){
           if(isset($_GET["page"]))
               $this->page = $_GET["page"];
       }
       $link = db_start();
       require 'pages/' . $this->page . '.php';
       $this->scope["page"] = $pageScope;
       db_end($link);
    }
}

session_start();
$_app = new app();
$_app->scope["page"]->process($_app);
/*
  If renderGui is true then render template of page
  otherwise do nothing becouse of all response login in page which required before.
 */
if($_app->renderUi)
    require 'templates/index.php';
?>
<?php


//require 'modules/accounts.php';
//require 'modules/languages.php';

//$account = new account();
//$account->language = "russian";
//$langs = new languages();

//echo $langs->translate("log in", "russian");

//$templates = new League\Plates\Engine('./templates');

// Render a template
//echo $templates->render('index', ['name' => 'Хохо']);


/*$link = mysql_connect('localhost', 'root', 'dataB00m')
      or die('Не удалось соединиться: ' . mysql_error());
mysql_select_db('integral') or die('Не удалось выбрать базу данных');

echo mysql_query("insert into test (ind) values('" . 89 . "')");

// Выполняем SQL-запрос
$query = 'SELECT * FROM test';
$result = mysql_query($query) or die('Запрос не удался: ' . mysql_error());

mysql_free_result($result);

mysql_close($link);
*/
?>