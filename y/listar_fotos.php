<?php
header('Content-Type: application/json; charset=utf-8');

$comando = "SELECT `id`, `texto`, `imagem` FROM `receber` WHERE `imagem` IS NOT NULL AND `imagem` != '' ORDER BY `id` ASC";

$dsn = 'mysql:dbname=texto;host=127.0.0.1';
$user = 'root';
$password = '';

$dbh = new PDO($dsn, $user, $password);

$resultado = $dbh->query($comando);
$linhas = $resultado->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($linhas, JSON_UNESCAPED_UNICODE);
?>

