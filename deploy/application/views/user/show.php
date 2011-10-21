
<?php include(VIEW_PATH . 'layouts/site_header.php'); ?>

<?php 
	
  echo '<h2>'. $user['first_name'] . ' ' . $user['last_name'] . '</h2>';
  echo $user['account_type'] . '</br>';
  
?>

<?php include(VIEW_PATH . 'layouts/site_footer.php'); ?>