<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<?php
// variable 
$var1 = 10;
// string 
$myString= "Hello World";

// for string:  .= is equivalent to += in actionscript 
// for number: += 
// echo strtolower($myString); strtoupper ucfirst
// $array1 = array(); calling array[0]; 
// an associate array: array("first-name" => "john")
$myBoolean = false;
// string = 0 which turn out to be 0(true) if test empty();
//echo $myBoolean;

print_r($_GET);
$id = $_GET['id'];
echo "<strong>". $id . "</strong>";

?>
</body>
</html>
