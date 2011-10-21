<?php

class Controller
{
     private static $instance;

     function Controller()
     {
	self::$instance =& $this;
	echo 'This is the Controller';
     }

     public function load()
     {
     }
}


?>
