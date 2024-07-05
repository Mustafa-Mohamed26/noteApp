<?php
    include "../connect.php";

    $username = filterRequest("username");
    $password = filterRequest("password");
    $email    = filterRequest("email");

    $stmt = $con->prepare("INSERT INTO `users` (`username`, `password`, `email`) VALUES (?, ?, ?)");
    $stmt->execute(array($username, $password, $email));

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status" => "success"));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>