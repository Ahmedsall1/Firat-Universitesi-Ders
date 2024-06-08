<?php

if ($_POST) {
    //verileri süzgeçten geçirerek alıyoruz

    $name = test_input($_POST["name"]);
    $surname = test_input($_POST["surname"]);
    $email = test_input($_POST["email"]);

    // verilerin hatalarını kontrol ediyoruz
    $errors = [];
    if (empty($name) or strlen($name) < 3)
        $errors[] = "Ad alanı en az 3 karakter olmalıdır";
    if (empty($surname) or strlen($surname) < 3)
        $errors[] = "Soyad alanı en az 3 karakter olmalıdır";
    if (empty($email) or !filter_var($email, FILTER_VALIDATE_EMAIL))
        $errors[] = "Geçerli bir email adresi giriniz";


    if (!empty($errors)) {
        echo "<center class='panel'>" . implode("<br>", $errors) . "</center>";

    } else {
        // burada ayrıca çoklu kayıt için select ile kontrol yapılabilir

        $insertQuery = $con->prepare("INSERT INTO ogrenciler(name,surname,email) VALUES(?,?,?)");
        $insertQuery->bind_param("sss", $name, $surname, $email);
        if ($insertQuery->execute()) {
            echo "Kayıt eklendi";

            echo " ID:" . $con->insert_id . "<br>";

        } else
            echo "DB error";

    }

}
?>
<form method="POST" class="form" style="width:400px;margin:auto;">
    <div class="form-group">
        <label for="ad">Ad:</label>
        <input type="text" value="<?= $name ?>" class="form-control" id="ad" name="name">
    </div>
    <div class="form-group">
        <label for="soyad">Soyad:</label>
        <input type="text" class="form-control" value="<?= $surname ?>" id="soyad" name="surname">
    </div>
    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" class="form-control" value="<?= $email ?>" id="email" name="email">
    </div>
    <button type="submit" class="btn btn-primary" name="ekle">Ekle</button>
</form>