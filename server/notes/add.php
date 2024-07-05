<?php
    include "../connect.php";

    $title = filterRequest("title");
    $content = filterRequest("content");
    $userId    = filterRequest("id");

    $stmt = $con->prepare("INSERT INTO `notes` (`notes_title`, `notes_content`, `notes_users`) VALUES (?, ?, ?)");
    $stmt->execute(array($title, $content, $userId));

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status" => "success"));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>