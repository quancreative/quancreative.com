<?php
	// starts a session
//    echo "Session starts.";

    session_start();
    session_name("quancreative.com");
//    echo ' Printing $_SESSION ';
//    print_r($_SESSION);
//    print(" session Name : " . session_name());

     // Holds the configuration for app, CONSTANTS ect...
     // if you change the directory of your app
     // * edit your routes in here.
     // * edit database params in here.
     include('config.php');

     function dispatcher($routes)
     {
	// Requested URL :: Get the address
	$url = $_SERVER["REQUEST_URI"];
//	echo '$url : ' . $url . '<br />'; // $url : /qcreative/deploy/admin/

	// Removes Application root from url.  String replace 'qcreative/deploy/' with blank/empty
	$url = str_replace(DIR_S . APP_ROOT . DIR_S, '', $url);
	// posts/2/edit
//	echo '$url : ' . $url . '<br />'; //
	// holds the named captures, $_POST and $_GET data
	$params = array();
	
	if (!empty($_POST))
	{
	     $params = array_merge($params, $_POST);
	}

	if (!empty($_GET))
	{
	     $params = array_merge($params, $_GET);
	}

//	echo 'QUERY_STRING :' .  $_SERVER['QUERY_STRING'] . '. ';
	// Removes query string from $url we don't need it anymore affect routes
	$url = str_replace('?'. $_SERVER['QUERY_STRING'], '', $url);
//	echo "url : " .  $url . " .";
	// becomes true if $route['url'] matches $url
	$route_match = false;
	$route = array();
	$total = count($routes);
	$controllerClassName;
	$controller;

	// loops over $routes looking for a match
	for ($i = 0; $i < $total; $i++)
	{
		//echo 'route : ' . $routes[$i]['url'] . '<br />';
		// $routes is in the config.php
  // assign the array of one of many array in $routes
		$route = $routes[$i];
		/*
		 * Perform Regular expression ($pattern, string, matches : Boolean)
		 *
		 * @param $pattern 	: regular expression
		 * @param $String 	: subject, The input string
		 * @param $matches	: If matches is provided, then it's filled with the results of search
		 */
		// if match found, appends $matches to $params
		// sets $route_match to true and also exits loop.
		if (preg_match($route['url'], $url, $matches))
		{
			$route_match = true;
//			echo '$matches : '; print_r($matches);
//			echo "<br />";
			// if there's nothing in $params, merging is useless
			$params = array_merge($params, $matches);
//			echo 'found match!';
			break;
		}
	}
	if ($matches)
	{
 //	     print('controller : ' . $route['controller'] . ' view : ' . $route['view'] . ' id : ' . $params['id']);
//	     echo '$params : ';
//	     print_r($params);

		     // includes the controller
		     include(CONTROLLER_PATH . $route['controller'] . '.php');
	     
//		     require_once $_SERVER['DOCUMENT_ROOT']. 'quancreative/deploy/application/controllers/Controller.php';
//		     require_once $_SERVER['DOCUMENT_ROOT']. 'quancreative/deploy/application/controllers/' . $route['controller'] . '.php';
//		     $controllerClassName = $route['controller'];
//		     $controller = new $controllerClassName;
		     
//		     echo '$controllerClassName' . $controllerClassName;
//		     echo $params[1];
//		     $sub_page = $params[0];
//		     $sub_page = str_replace('test/', '', $sub_page);
//		     echo $sub_page;
//		     $controller->$sub_page();
		     
//
		     if (file_exists(VIEW_PATH . $route['controller'] . '/' . $route['view'] . '.php'))
		     {
			// includes the view
			include(VIEW_PATH . $route['controller'] . '/' . $route['view'] . '.php');
		     }else
		     {
			// includes default layout
			include(VIEW_PATH . 'layouts/application.php');
		     }
	     }
	     else
	     {
//		 echo "The page you're looking doesn't exist! :P";
		// If the url is blank then it must be anchor or landing page. Direct to flash
		include(VIEW_PATH . 'flash/index.php');

	     }
     }
	
     dispatcher($routes);
	
     /**
      * Returns array of $_GET and $_POST data
      * @return array
      */
     function parse_params()
     {
	$params = array();

	if (!empty($_POST))
	{
	     $params = array_merge($params, $_POST);
	}

	return $params;
     }
	
     // strips out escape characters
     function stripslashes_deep($value)
     {
         $value = is_array($value) ? array_map('stripslashes_deep', $value) : stripslashes($value);
         return $value;
     }
?>