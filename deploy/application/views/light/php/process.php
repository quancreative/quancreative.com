<?php

$quanEmail= "quancreative@gmail.com";

$userName= $_POST['name'];
$userEmail = $_POST['email'];
$userMessage = $_POST['message'];

$emailSubject = "Mail from contact light version";
$emailHeader = "From: $userEmail";
$emailHeader .= "\nReply-To: $userEmail";

mail($quanEmail,$emailSubject, $userMessage, $emailHeader);

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>quan creative - thank you</title>
<meta name="description" content="Hand-crafted pixels and text by Quan Ngo." />
<meta name="keywords" content="quancreative, quan, creative, Quan Ngo, quan, ngo, web standards, CSS, XHTML, markup, style, freelance, web design, web development, goodies" />
<meta name="author" content="Quan Creative" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>


<h1>Thank you.</h1>
<p>Your message has been sent successfuly</p>    
<p><a href="../#contact">Click here</a> to go back to quancreative.</p>


<?php include("../../includes/google_tracking.php"); ?>

</body>
</html>