<?php
    include "../connect.php";

    $noteID = filterRequest("id");
    $title = filterRequest("title");
    $content = filterRequest("content");
    $imageName = filterRequest("imageName");

    if(isset($_FILES['file'])){
        deleteFile("../upload", $imageName);
        $imageName = imageUpload("file");
    }

    $stmt = $con->prepare("UPDATE `notes` SET notes_title = ? , notes_content = ? , notes_image = ?  WHERE notes_id = ?");
    $stmt->execute(array($title, $content, $imageName , $noteID));

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status" => "success"));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>