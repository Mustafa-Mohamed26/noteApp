<?php
    include "../connect.php";

    $noteID = filterRequest("id");
    $title = filterRequest("title");
    $content = filterRequest("content");

    $stmt = $con->prepare("UPDATE `notes` SET notes_title = ? , notes_content = ? WHERE notes_id = ?");
    $stmt->execute(array($title, $content, $noteID));

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status" => "success"));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>