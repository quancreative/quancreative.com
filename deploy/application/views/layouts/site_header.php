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
          <?php if (isset($_SESSION['user'])  && $_SESSION['user'] == 1) : ?>
               <div id="logout">
                    <hr />
                    <a href="<?php echo DIR_S . APP_ROOT . DIR_S;  ?>admin/logout">Sign Out</a>
                    <hr />
               </div>
          <?php endif; ?>
     </div><!-- end #header -->

     <div id="center-piece">

          <div id="left-bar">

          </div>

          <div id="main-content">