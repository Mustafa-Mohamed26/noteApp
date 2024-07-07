<?php

    define('MB', 1048576);

    /**
     * This function takes a request name as a parameter and applies some sanitization
     * to the corresponding value in the $_POST superglobal.
     *
     * It uses the htmlspecialchars function to convert special characters to their
     * corresponding HTML entities. This helps prevent cross-site scripting (XSS) attacks.
     *
     * It also uses the strip_tags function to remove any HTML or PHP tags from the
     * input. This helps prevent the execution of malicious code.
     *
     * @param string $requestName The name of the request parameter to filter.
     * @return string The filtered value of the request parameter.
     */
    function filterRequest($requestName){
        // Apply htmlspecialchars to convert special characters to HTML entities.
        // This helps prevent XSS attacks.
        $filteredValue = htmlspecialchars(strip_tags($_POST[$requestName]));
        
        // Return the filtered value.
        return $filteredValue;
    }

    /**
     * This function handles the image upload process.
     *
     * It generates a random name for the uploaded image and checks if the file
     * extension is allowed. It also checks if the file size is within the allowed range.
     *
     * If the file passes all the checks, it moves the uploaded file to the "../upload/"
     * directory and returns the name of the uploaded image.
     *
     * If any of the checks fail, it adds an error message to the global $msgError array.
     *
     * @param string $imageRequest The name of the $_FILES array element containing the uploaded image.
     * @return string|null The name of the uploaded image if the upload is successful.
     *                     Otherwise, it returns "fail".
     */
    function imageUpload($imageRequest){
        // Initialize the global error message array.
        global $msgError;

        // Generate a random name for the uploaded image.
        $imageName = rand(1000, 10000) . $_FILES[$imageRequest]['name'];

        // Get the temporary file path of the uploaded image.
        $imageTmp = $_FILES[$imageRequest]['tmp_name'];

        // Get the size of the uploaded image.
        $imageSize = $_FILES[$imageRequest]['size'];

        // Define the allowed file extensions.
        $allowExt = array("jpg", "png", "gif", "mp3", "pdf");

        // Split the image name into an array using the "." delimiter.
        $strToArray = explode(".", $imageName);

        // Get the last element of the array, which is the file extension.
        $ext = end($strToArray);

        // Convert the file extension to lowercase.
        $ext = strtolower($ext);

        // Check if the file extension is allowed.
        if(!empty($imageName) && !in_array($ext, $allowExt)){
            // If the file extension is not allowed, add an error message to the error array.
            $msgError[] = "Ext"; 
        }

        // Check if the file size is within the allowed range (2MB).
        if($imageSize > 2 * MB){
            // If the file size is too large, add an error message to the error array.
            $msgError[] = "size";
        }

        // Check if there are any error messages in the error array.
        if(empty($msgError)){
            // If there are no error messages, move the uploaded file to the "../upload/" directory.
            move_uploaded_file($imageTmp, "../upload/" . $imageName);

            // Return the name of the uploaded image.
            return $imageName;
        }else{
            // If there are error messages, return "fail".
            return "fail";
        }
        
    }

    /**
     * This function deletes a file.
     *
     * It takes two parameters:
     * - $direction: a string representing the directory where the file is located.
     * - $imageName: a string representing the name of the file to be deleted.
     *
     * It checks if the file specified by $direction and $imageName exists.
     * If the file exists, it uses the unlink() function to delete the file.
     * 
     * This function does not return anything.
     */
    function deleteFile($direction, $imageName){
        // Check if the file specified by $direction and $imageName exists.
        if(file_exists($direction . "/" . $imageName)){
            // If the file exists, use the unlink() function to delete the file.
            unlink($direction . "/" . $imageName);
        }
    }

    
    /**
     * This function checks if the user is authenticated.
     *
     * It checks if the 'PHP_AUTH_USER' and 'PHP_AUTH_PW' server variables are set.
     * If they are set, it checks if the username and password match the expected values.
     * If they match, the function returns without doing anything.
     * If they don't match, it sets the appropriate HTTP headers and echoes a message indicating that the page is not found.
     * If the 'PHP_AUTH_USER' and 'PHP_AUTH_PW' server variables are not set, it exits the script.
     *
     * Note: The 'PHP_AUTH_USER' and 'PHP_AUTH_PW' server variables are set by the web server when the user provides valid credentials for HTTP authentication.
     *
     * This function does not return anything.
     */
    function checkAuthenticate(){
        // Check if the 'PHP_AUTH_USER' and 'PHP_AUTH_PW' server variables are set.
        if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
            // Check if the username and password match the expected values.
            if ($_SERVER['PHP_AUTH_USER'] != "wael" ||  $_SERVER['PHP_AUTH_PW'] != "wael12345"){
                // If they don't match, set the appropriate HTTP headers and echo a message indicating that the page is not found.
                header('WWW-Authenticate: Basic realm="My Realm"');
                header('HTTP/1.0 401 Unauthorized');
                echo 'Page Not Found';
                // Exit the script to prevent further execution.
                exit;
            }
        } else {
            // If the 'PHP_AUTH_USER' and 'PHP_AUTH_PW' server variables are not set, exit the script.
            exit;
        }
    }
?>