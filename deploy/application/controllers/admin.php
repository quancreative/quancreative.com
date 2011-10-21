<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
    include(MODEL_PATH . '/admin.php');

//    echo 'admin controller :' . '<br />';
//    echo '$route view : ' . $route['view'] . '<br />';
    
     switch ($route['view'])
     {
          case "index" :
               
          break;

          case "login" :
               //print_r($params['user']['email']);
               $login_result = login($params['user']['email'], $params['user']['password']);
               echo 'login_result : ';
//               print_r($login_result);
//               $_SESSION['user']['email'] = $params['user']['email'];
	  
               redirect_to('admin');
          break;

          case "logout" :
               $_SESSION['user'] = null;
               redirect_to('admin');
          break;

          case "portfolio" :
               check_authentication();
               $portfolio_pieces = find_portfolio_pieces();
          break;

          case "portfolio_create" :
               check_authentication();
               echo 'portfolio create controller';
               
               if (create_portfolio_piece($params['portfolio_piece']))
               {
                    echo 'E:   dfdf :::: testing';
                    flash_notice("Successfully created a portfolio piece!");
                    redirect_to('admin/portfolio');
                    //echo 'Successfully created post!<br />';
               }
               else
               {
                    echo 'unable to create portfolio piece.';
               }
          break;

          case "portfolio_delete" :
               check_authentication();

               if (delete_portfolio_piece($params['id']))
               {
                    
               }

          break;

          case "portfolio_update" :
               check_authentication();
               if (update_portfolio_piece($params['portfolio_piece']))
               {
                    redirect_to('admin/portfolio');
               }
               else
               {
                    echo 'Unable of update portfolio piece.';
               }
          break;

	case "account" :
	     check_authentication();
	     $user = find_user(1);
	break;
     }
?>
