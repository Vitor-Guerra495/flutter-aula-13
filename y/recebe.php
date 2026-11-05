<?php
header('Content-Type: application/json; charset=utf-8');

$id = $_GET["id"] ?? 0;

$comando = "SELECT `id`, `texto`, `imagem` FROM `receber` WHERE `id` > $id AND `imagem` IS NOT NULL AND `imagem` != '' ORDER BY `id` ASC LIMIT 1";

$dsn = 'mysql:dbname=texto;host=127.0.0.1';
$user = 'root';
$password = '';

$dbh = new PDO($dsn, $user, $password);

$resultado = $dbh->query($comando);
$linha = $resultado->fetch(PDO::FETCH_ASSOC);

if($linha) {
    $linha['id'] = (int)$linha['id'];
    echo json_encode($linha, JSON_UNESCAPED_UNICODE);
} else {
    echo "{}";
}
?>
