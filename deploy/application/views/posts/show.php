<?php include(VIEW_PATH . 'layouts/site_header.php'); ?>

<?php 

	include('_post.php');

?>
<p>[ <a href="<?php echo WEBSITE . APP_ROOT . '/posts/' . $params['id'] . '/edit'; ?>">edit</a> ]</p>

<?php include(VIEW_PATH . 'layouts/site_footer.php'); ?>