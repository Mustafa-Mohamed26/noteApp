<?php
    include "../connect.php";

    $title = filterRequest("title");
    $content = filterRequest("content");
    $userId    = filterRequest("id");

    $imageName = imageUpload("file");

    if($imageName != 'fail'){
        $stmt = $con->prepare("INSERT INTO `notes` (`notes_title`, `notes_content`, `notes_users`, `notes_image`) VALUES (?, ?, ?, ?)");
        $stmt->execute(array($title, $content, $userId, $imageName));

        $count = $stmt->rowCount();

        if($count > 0){
            echo json_encode(array("status" => "success"));
        }else{
            echo json_encode(array("status" => "fail"));
        }
    } else {
        echo json_encode(array("status" => "fail"));
    }

    
?>