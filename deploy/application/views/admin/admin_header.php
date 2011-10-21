<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<link rel="stylesheet" type="text/css" media="all" href="<?php echo DIR_S . APP_ROOT . DIR_S; ?>css/screen.css" charset="utf-8" />

<script type="text/javascript" src="<?php echo DIR_S . APP_ROOT . DIR_S; ?>js/jquery-1.4.2.min.js"></script>

</head>

<body class="page-<?php echo $route['view']; ?>">

     <div id="header">

          <h3><a href="<?php echo DIR_S . APP_ROOT; ?>"><- View Site</a></h3>
          <?php if (isset($_SESSION['user'])) : ?>
	<div id="top-nav">
	     <ul>
		<li>
		     <p>Welcome back <?php echo $_SESSION['user']['first_name']; ?></p>
		</li>
		<li>
		     <a href="<?php echo DIR_S . APP_ROOT; ?>/account">Account</a>
		</li>
		<li>
		     <a href="<?php echo DIR_S . APP_ROOT; ?>/admin/logout">Log out</a>
		</li>
	     </ul>
	</div><!-- end top-nav -->

	<div id="tabs-container">
	     <ul>
		<li class="tab">
		     <a href="<?php echo DIR_S . APP_ROOT; ?>/admin">admin</a>
		</li>

		<li class="tab">
		     <a href="<?php echo DIR_S . APP_ROOT; ?>/admin/portfolio">Portfolio</a>
		</li>

		<li class="tab">
		     <a href="<?php echo DIR_S . APP_ROOT; ?>/user">User</a>
		</li>
	     </ul>

	</div>

          <?php endif; ?>
     </div><!-- end #header -->

     <div id="main-content">
          
          <div id="center-content">

