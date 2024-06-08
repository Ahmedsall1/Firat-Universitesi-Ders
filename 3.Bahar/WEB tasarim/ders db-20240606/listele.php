<?php
$sql = "SELECT * FROM ogrenciler";

$result = $con->query($sql);

if ($result->num_rows > 0) {
    echo $result->num_rows . " kayıt bulundu<br>";
    echo "<table class='table table-hover'>
        <tr><th>Id</th><th>Adı Soyadı</th>
        <th>Email</th><th>İşlem</th></tr>";
    while ($row = $result->fetch_assoc()) {
        //var_dump($row);
        echo "<tr>
            <td>" . $row["id"] . "</td>
            <td>" . $row["name"] . " " . $row["surname"] . "</td>
            <td>" . $row["email"] . "</td>
            <td><a onclick=\"return confirm('Eminmisiniz?')\" href='delete.php?id=" . $row["id"] . "' class='btn btn-danger'>Sil</a></td>
            </tr>
            ";
    }
    echo "</table>";
} else {
    echo "Tabloda öğrenci yok";
}
?>