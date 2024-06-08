<?php
include ("connection.php");

$id = intval($_GET["id"]);
// öncelikle öğrenci varmı yokmu kontrol edilebilir

$sql = "DELETE FROM ogrenciler WHERE id=$id";
$result = $con->query($sql);
if ($result) {
    echo "Silindi";

} else {
    echo "Silinemedi";
}
?>
<script>
    setTimeout(function () {
        window.location.href = "students.php";
    }, 2000);
</script>