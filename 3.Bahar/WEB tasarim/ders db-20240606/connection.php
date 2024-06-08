<?php

// don't display warnings
error_reporting(E_ERROR | E_PARSE);

$con = new mysqli("localhost", "root", "", "ders3");
if ($con->connect_error) {
    die("Connection failed: ");
} else
    echo "Connected successfully.<br>";


function test_input($data)
{
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}