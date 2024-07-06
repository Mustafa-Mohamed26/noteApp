<?php

    define('MB', 1048576);

    function filterRequest($requestName){
        return htmlspecialchars(strip_tags($_POST[$requestName]));
    }

    function imageUpload($imageRequest){
        global $msgError;
        $imageName = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
        $imageTmp = $_FILES[$imageRequest]['tmp_name'];
        $imageSize = $_FILES[$imageRequest]['size'];
        $allowExt = array("jpg", "png", "gif", "mp3", "pdf");

        $strToArray = explode(".", $imageName);
        $ext = end($strToArray);
        $ext = strtolower($ext);

        if(!empty($imageName) && !in_array($ext, $allowExt)){
            $msgError[] = "Ext"; 
        }
        if($imageSize > 2 * MB){
            $msgError[] = "size";
        }
        if(empty($msgError)){
            move_uploaded_file($imageTmp, "../upload/" . $imageName);
            return $imageName;
        }else{
            return "fail";
        }
        
    }
?>