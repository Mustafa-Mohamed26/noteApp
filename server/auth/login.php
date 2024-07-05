<?php
    include "../connect.php";

    $password = filterRequest("password");
    $email    = filterRequest("email");

    $stmt = $con->prepare("SELECT * FROM users WHERE `password` = ? AND email = ?");
    $stmt->execute(array($password, $email));

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status" => "success"));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>