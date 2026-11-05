<?php
$texto = $_REQUEST["txt"] ?? "";
$caminhoImagem = "";

if (isset($_FILES["imagem"]) && $_FILES["imagem"]["error"] == 0) {
    $temp = $_FILES["imagem"]["tmp_name"];
    $nome = time() . "_" . basename($_FILES["imagem"]["name"]);
    $destino = "fotos/" . $nome;

    if (copy($temp, $destino)) {
        $caminhoImagem = $destino;
    }
}

$comando = "INSERT INTO `receber` (`id`, `texto`, `imagem`) VALUES (NULL, '$texto', '$caminhoImagem')";

$dsn = 'mysql:dbname=texto;host=127.0.0.1';
$user = 'root';
$password = '';

$dbh = new PDO($dsn, $user, $password);

$resultado = $dbh->query($comando);

if($resultado) {
    echo "Salvo com sucesso!";
} else {
    echo "Erro ao salvar!";
}
?>
