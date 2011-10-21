<?php 

     include($_SERVER['DOCUMENT_ROOT']. APP_ROOT . '/models/post.php');

     switch ($route['view'])
     {
	case "show" :
	     $post = find_post($params['id']);
//		echo "this is the show action";
	     // this is now on the main page
//	     include($_SERVER['DOCUMENT_ROOT'].'quancreative/deploy/views/posts/show.php');
	break;

	case "index" :
	     $posts = find_posts();
	break;

	case "edit" :
	     $post = find_post($params['id']);
	break;

	case "new" :
	     $post = find_post(1);
	     echo "this is the new action";
	break;

	case "create" :
	     if (create_post($params['post']))
	     {
		flash_notice("Successfully created post!");
		redirect_to('posts');
		//echo 'Successfully created post!<br />';
	     }
	break;
     }
?>