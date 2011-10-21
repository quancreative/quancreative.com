<?php include(VIEW_PATH . 'admin/admin_header.php'); ?>

<?php
	foreach ($portfolio_pieces as $piece):
	     include('_portfolio_piece.php');
	endforeach;
?>

<div class="portfolio-piece-new">
     <fieldset>
          <legend>Add A New Piece</legend>
          <form action="<?php echo DIR_S . APP_ROOT . DIR_S . 'admin/portfolio/create'; ?>" method="post" >
               <input name="portfolio_piece[user_id]" value="<?php echo $_SESSION['user']; ?>" type="hidden"/>
               
               <div class="input-wrapper">
                    <label for="edit-title">Title</label>
                    <input id="edit-title" class="required input-text" name="portfolio_piece[title]" type="text" maxlength="225" value="" />
               </div>

               <div class="input-wrapper">
                    <label for="">Image : </label>
                    <!--
                    <input id="" class="" type="file" name="portfolio_piece[media]" accept="png,jpg,jpeg" />
                    <input id="" class="" type="submit" value="Upload" />
                    -->
                    <input class="required input-text" name="portfolio_piece[media]" type="text" maxlength="225" />
               </div>

               <div class="input-wrapper">
                    <label for="edit-description">Description : </label>
                    <textarea id="edit-description" class="required input-text" name="portfolio_piece[description]"rows="5" cols="60"></textarea>
               </div>

               <div class="input-wrapper">
                    <label for="edit-link">Link :</label>
                    <input id="" class="required input-text" name="portfolio_piece[link]"type="text" maxlength="225" value="" />
               </div>

               <div class="input-wrapper">
                    <label for="edit-order">Position :</label>
                    <input id="" name="portfolio_piece[position]" value="1" />
               </div>

               <br />
               <label for="enable">Enable :</label>
               <select name="portfolio_piece[enable]">
                    <option value="0">0</option>
                    <option value="1" selected="selected">1</option>
               </select>
               <br />
               <input id="" class="input-btn" type="submit" value="Add" />
          </form>
     </fieldset>
</div>

<?php include(VIEW_PATH . 'admin/admin_footer.php'); ?>