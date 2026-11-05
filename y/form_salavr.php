<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Enviar Foto e Descrição</title>
</head>
<body>
    <form action="salvar.php" method="post" enctype="multipart/form-data">
        <label>Descrição:</label>
        <input type="text" name="txt">
        <br><br>
        <label>Foto:</label>
        <input type="file" name="imagem" accept="image/*">
        <br><br>
        <input type="submit" value="Salvar">
    </form>
</body>
</html>
