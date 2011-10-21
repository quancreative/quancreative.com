# this is the new view.

<fieldset>
	<legend>Add a new Post.</legend>
	<form action="<?php echo DIR_S . APP_ROOT . DIR_S . 'posts/create?somevar=value'; ?>" method="post">
	
	<div>
		<input name="post[title]" size="40" type="text" />
	</div>
	
	<div>
		<textarea name="post[body]" rows="5" cols="40"></textarea>
	</div>
	<input name="post[user_id]" value="1" type="hidden"/>
	<input type="submit" value="save" />
	
	</form>
</fieldset>