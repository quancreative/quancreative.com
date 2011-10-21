
<div class="portfolio-piece-edit">
     <form action="<?php  echo WEBSITE . APP_ROOT . '/admin/portfolio/' . $piece['id'] . '/update'; ?>" method="post">
          <fieldset>
               <legend><?php echo $piece['title']; ?></legend>

               <input name="portfolio_piece[id]" value="<?php echo $piece['id']; ?>" type="hidden"/>
               <input name="portfolio_piece[user_id]" value="<?php echo $_SESSION['user']; ?>" type="hidden"/>

	     <div class="portfolio-piece-img">
		<div class="input-wrapper">
		     <label for="">Image : </label>
		     <img style="width : 300px" src="<?php echo WEBSITE . DIR_S . APP_ROOT . $piece['media']; ?>" alt="" />
		     <input id="edit-media" class="input-text" name="portfolio_piece[media]" value="<?php echo $piece['media']; ?>" type="text" maxlength="225" width="200px" />
		     <!--
		     <input id="" class="" name="portfolio_piece[field_portfolio_image]" type="file" accept="png,jpg,jpeg" />
		     <input id="" class="" type="submit" value="Upload" />
		     -->
		</div>
	     </div>

	     <div class="portfolio-piece-content">
		<div class="input-wrapper">
		     <label for="edit-title">Title</label>
		     <input id="edit-title" class="input-text required" name="portfolio_piece[title]" value="<?php echo $piece['title']; ?>" type="text" maxlength="225" />
		</div>
		
		<div class="input-wrapper">
		     <label for="edit-description">Description : </label>
		     <textarea id="edit-description" class="input-text" name="portfolio_piece[description]" rows="5" cols="60"><?php echo $piece['description']; ?></textarea>
		</div>

		<div class="input-wrapper">
		     <label for="edit-link">Link :</label>
		     <input id="edit-link" class="input-text" name="portfolio_piece[link]" value="<?php echo $piece['link']; ?>" type="text" maxlength="225" />
		</div>

		<div class="input-wrapper">
		     <label for="edit-order">Position :</label>
		     <input id="edit-order" class="input-text" name="portfolio_piece[position]" value="<?php echo $piece['position']; ?>" />

		     <label for="enable">Enable :</label>
		     <select name="portfolio_piece[enable]">
			<option value="0"<?php if ($piece['enable'] == 0) echo ' selected="selected"'; ?>>0</option>
			<option value="1"<?php if ($piece['enable'] == 1) echo ' selected="selected"'; ?>>1</option>
		     </select>
		</div>

		<div class="input-wrapper">
		     <input id="edit-save" class="input-btn" type="submit" value="Save" />
		</div>
		<!--
		<input id="edit-delete" class="form-submit" type="submit" value="Delete" />
		-->
	     </div>
          </fieldset>
     </form>
</div>

