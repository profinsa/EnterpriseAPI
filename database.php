use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule;
$config = config();
$capsule->addConnection([
    "driver" => "mysql",
    "host" => $config["db_host"],
    "database" => $config["db_base"],
    "username" => $config["db_user"],
    "password" => $config["db_password"],
    "charset" => "utf8",
    "collation" => "utf8_unicode_ci",
    "prefix" => ""
]);
$capsule->setAsGlobal();
