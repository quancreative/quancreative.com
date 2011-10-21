<?php

$to = "quancreative@gmail.com";
$subject = "flash contact form submission";
$message = "Name: " . $userName;
$message .= "\nEmail: " . $userEmail;
$message .= "\n\nMessage: " . $userMessage;
$headers = "From: $userEmail";
$headers .= "\nReply-To: $userEmail";

$sentOk = mail($to, $subject, $message, $headers);

$returnMessage = "Thank you!";
$returnMessage .= "\n\n I will contact you shortly.";
echo $returnMessage;

/* 
$returnMessage = "quan";
$returnMessage .= "$subject";

echo $returnMessage;
*/

?>



