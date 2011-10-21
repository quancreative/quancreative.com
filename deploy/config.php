<?php
	// routes url to controller and view	
	// matches with regular expression and associates with the controller directory and the php file with the parameter
	$routes = array(
	     array('url' => '/^user\/?$/', 		'controller' => 'user', 'view' => 'index'),
	     array('url' => '/^user\/login$/',		'controller' => 'user', 'view' => 'login'),
	     array('url' => '/^user\/show$/',		'controller' => 'user', 'view' => 'show'),
	     array('url' => '/^user\/fail$/',		'controller' => 'user', 'view' => 'fail'),

	     array('url' => '/^posts\/(?P<id>\d+)$/', 		'controller' => 'posts', 'view' => 'show'),
	     array('url' => '/^posts\/(?P<id>\d+)\/edit$/', 	'controller' => 'posts', 'view' => 'edit'),
	     array('url' => '/^posts\/new$/', 			'controller' => 'posts', 'view' => 'new'),
	     array('url' => '/^posts\/create$/',		'controller' => 'posts', 'view' => 'create'),
	     array('url' => '/^posts\/?$/',			'controller' => 'posts', 'view' => 'index'),

	     array('url' => '/^admin\/?$/',                              'controller' => 'admin', 'view' => 'index'),
	     array('url' => '/^admin\/login$/',                          'controller' => 'admin', 'view' => 'login'),
	     array('url' => '/^admin\/logout$/',                         'controller' => 'admin', 'view' => 'logout'),
	     array('url' => '/^admin\/portfolio$/',                      'controller' => 'admin', 'view' => 'portfolio'),
	     array('url' => '/^admin\/portfolio\/create$/',              'controller' => 'admin', 'view' => 'portfolio_create'),
	     array('url' => '/^admin\/portfolio\/(?P<id>\d+)\/update/',  'controller' => 'admin', 'view' => 'portfolio_update'),

	     array('url' => '/^account\/?$/',                             'controller' => 'admin', 'view' => 'account'),

	     array('url' => '/^test\/?$/',                             'controller' => 'Test', 'index'),
	     array('url' => '/^test\/portfolio$/',                      'controller' => 'Test'),

	     array('url' => '/^light\/?$/',                  'controller' => 'light', 'view' => 'index')
	);
	// Lesson 7 :: Routing system
	// perform regular expression match :: posts/2
	// (?P<id>) :: ?p<id>capture the id, \d :: capture only decimal, + :: capture one or more, $ :: must end in a decimal 
	// return :: Array ( [0] => posts/2 [id] => 2 [1] => 2 ) 
	//preg_match('/^posts\/(?P<id>\d+)$/', $url, $matches);
	//print_r($matches);
	//echo $url;
	
	// Database connection params
	define('HOST', 'localhost');
	define('USERNAME', 'quancreativecom');
	define('PASSWORD', 'Creative21');
	define('DATABASE', 'quancreativecom');
	
	// The Server Root
	define('SERVER_ROOT', $_SERVER['DOCUMENT_ROOT']);

	// Directory structure
	define("DIR_S", '/');
	
	// Application Directory - need to change this to your app folder.
	define('APP_ROOT', 'quancreative/deploy');
	
	// Address of website.
	define('WEBSITE', 'http://localhost/');

	// MVC paths
	define('MODEL_PATH'		, SERVER_ROOT . APP_ROOT . DIR_S . 'application/models' . DIR_S);
	define('VIEW_PATH'		, SERVER_ROOT . APP_ROOT . DIR_S . 'application/views' . DIR_S);
	define('CONTROLLER_PATH', SERVER_ROOT . APP_ROOT . DIR_S . 'application/controllers' . DIR_S);
	
//	echo MODEL_PATH;
//	echo '<br />';
//	echo VIEW_PATH;
//	echo '<br />';
//	echo CONTROLLER_PATH;
	
	// lib includes
	include('application/lib/database.php');
	include('application/lib/controller.php');
?>
