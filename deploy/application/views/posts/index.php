<?php include(VIEW_PATH . 'layouts/site_header.php'); ?>

<?php echo 'this is the index.php in view.post'; ?>

<?php 
	foreach ($posts as $post): 
	include('_post.php');
	endforeach; 
?>

<?php include(VIEW_PATH . 'layouts/site_footer.php'); ?>