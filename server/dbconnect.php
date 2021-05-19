<?php
$servername = "localhost";
$username   = "hubbuddi_270607myshopdbadmin";
$password   = "Pqu2@)(cmVs9";
$dbname     = "hubbuddi_270607_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>