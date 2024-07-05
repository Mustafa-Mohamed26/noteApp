<?php
    function filterRequest($requestName){
        return htmlspecialchars(strip_tags($_POST[$requestName]));
    }
?>