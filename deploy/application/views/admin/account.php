<?php include(VIEW_PATH . 'admin/admin_header.php'); ?>
<h3>Account Settings</h3>

<div class="account-edit">
     <fieldset>
          <legend>User Info</legend>
          <form action="<?php echo DIR_S . APP_ROOT . DIR_S . 'admin/account/edit'; ?>" method="post" >
               <input name="user[user_id]" value="<?php echo $_SESSION['user']; ?>" type="hidden"/>

	     <div class="input-wrapper">
		<label for="first-name">First name</label>
		<input id="first-name" class="required input-text" name="user[first_name]" value="<?php echo $_SESSION['user']['first_name']; ?>" type="text" size="40" />
	     </div>

	     <div class="input-wrapper">
		<label for="last-name">Last name</label>
		<input id="last-name" class="required input-text" name="user[last_name]" value="<?php echo $_SESSION['user']['last_name']; ?>" type="text" size="40" />
	     </div>
	     
	     <div class="input-wrapper">
		<label for="email">Email</label>
		<input id="email" class="required input-text" name="user[email]" value="<?php echo $_SESSION['user']['email']; ?>"type="text" size="40" />
	     </div>
	   
	     <div class="input-wrapper">
		<input class="input-btn" type="submit" value="Save" />
	     </div>

          </form>
     </fieldset>
</div>

<div class="account-password-edit">
     <fieldset>
          <legend>Password Reset</legend>
          <form action="<?php echo DIR_S . APP_ROOT . DIR_S . 'admin/account/edit'; ?>" method="post" >
               <input name="user[user_id]" value="<?php echo $_SESSION['user']; ?>" type="hidden"/>

	     <div class="input-wrapper">
		<label for="old-password">Old password</label>
		<input id="old-password" class="required input-text" name="user[first_name]" value="" type="text" size="40" />
	     </div>

	     <div class="input-wrapper">
		<label for="new-password">New password</label>
		<input id="new-password" class="required input-text" name="user[password]" value="" type="text" size="40" />
	     </div>

	     <div class="input-wrapper">
		<label for="confirm-password">Confirm password</label>
		<input id="confirm-password" class="required input-text" name="user[email]" value="" type="text" size="40" />
	     </div>

	     <div class="input-wrapper">
		<input class="input-btn" type="submit" value="Save" />
	     </div>

          </form>
     </fieldset>
</div>
<?php include(VIEW_PATH . 'admin/admin_footer.php'); ?>