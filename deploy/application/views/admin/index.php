
<?php include(VIEW_PATH . 'admin/admin_header.php'); ?>

<?php
     
     if (isset($_SESSION['user']))
     {
          include(VIEW_PATH . 'admin/_index.php');
     }
     else
     {
          include(VIEW_PATH . 'admin/_login_form.php');
     }
?>

<?php include(VIEW_PATH . 'admin/admin_footer.php'); ?>