<?php
    include "../connect.php";

    $noteID = filterRequest("id");
    $imageName = filterRequest("imageName");

    $stmt = $con->prepare("DELETE FROM notes WHERE notes_id = ?");
    $stmt->execute(array($noteID));

    $count = $stmt->rowCount();

    if($count > 0){
        deleteFile("../upload", $imageName);
        echo json_encode(array("status" => "success"));
    }else{
        echo json_encode(array("status" => "fail"));
    }
?>