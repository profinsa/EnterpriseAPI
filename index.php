<?php
class app{
    public $title = 'Integral Accounting X';
    public $page = 'main';
    public function __construct(){
        if(isset($_GET["page"])){
            $this->page = $_GET["page"];
        }
    }
}

$_app = new app();
require 'templates/index.php';
?>
<?php

//require 'vendor/autoload.php';

//require 'modules/accounts.php';
//require 'modules/languages.php';

//$account = new account();
//$account->language = "russian";
//$langs = new languages();

//echo $langs->translate("log in", "russian");

//$templates = new League\Plates\Engine('./templates');

// Render a template
//echo $templates->render('index', ['name' => 'Хохо']);

// Соединяемся, выбираем базу данных
//echo new mysqli('localhost', 'root', 'dataB00m', 'integral');
/*$link = mysql_connect('localhost', 'root', 'dataB00m')
      or die('Не удалось соединиться: ' . mysql_error());
echo 'Соединение успешно установлено';
mysql_select_db('integral') or die('Не удалось выбрать базу данных');

echo mysql_query("insert into test (ind) values('" . 89 . "')");

// Выполняем SQL-запрос
$query = 'SELECT * FROM test';
$result = mysql_query($query) or die('Запрос не удался: ' . mysql_error());

// Выводим результаты в html
echo $_GET["lom"];
echo "<ul>\n";
while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
    echo "\t<li>\n";
    foreach ($line as $col_value) {
        echo "\t\t$col_value\n";
    }
    echo "\t</li>\n";
}
echo "</ul>\n";

// Освобождаем память от результата
mysql_free_result($result);

// Закрываем соединение
mysql_close($link);
*/
?>