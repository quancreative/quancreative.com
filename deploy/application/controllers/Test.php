<?php
class Test extends Controller
{
     function  __construct()
     {
	parent::Controller();
	echo 'this is the class Test';
     }

     function portfolio()
     {
	echo '<br /> this is portfolio class.';
     }
}
?>
