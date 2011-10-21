 <?php
     check_authentication();
     
     include(MODEL_PATH . '/user.php');

     switch ($route['view'])
     {
	case "show" :
	     $user = find_user(1);
	break;
     }
?>