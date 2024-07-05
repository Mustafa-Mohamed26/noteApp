<?php
    include "../connect.php";

    $password = filterRequest("password");
    $email    = filterRequest("email");

    $stmt = $con->prepare("SELECT * FROM users WHERE `password` = ? AND email = ?");
    $stmt->execute(array($password, $email));

    $data = $stmt->fetch(PDO::FETCH_ASSOC);

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status" => "success", "data" => $data));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>