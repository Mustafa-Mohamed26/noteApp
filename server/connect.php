<?php 
    $dsn = "mysql:host=localhost;dbname=noteapp";
    $username = "root";
    $password = "";
    $option = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'); // for arabic

    try{
        $con = new PDO($dsn, $username, $password, $option);
        $con -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        include "../functions.php";
    }catch(PDOException $e){
        echo $e -> getMessage();
    }
    
    
?>
