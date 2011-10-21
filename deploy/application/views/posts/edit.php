<?php include(VIEW_PATH . 'layouts/site_header.php'); ?>

<h1>This is the edit page</h1>

<fieldset>
	<legend>Edit a Post.</legend>
	<form action="<?php echo WEBSITE . APP_ROOT . '/posts/' . $params['id'] . '/update'; ?>" method="post">
	
	<div>
		<input name="post[title]" size="40" type="text" value="<?php echo $post['title']; ?>" />
	</div>
	
	<div>
		<textarea name="post[body]" rows="5" cols="40"><?php echo $post['body']; ?></textarea>
	</div>
	<input name="post[user_id]" value="<?php echo $params['id']; ?>" type="hidden"/>
	<input type="submit" value="save" />
	
	</form>
</fieldset>

<?php include(VIEW_PATH . 'layouts/site_footer.php'); ?>