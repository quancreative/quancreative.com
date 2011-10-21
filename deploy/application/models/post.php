<?php 
			
	/*
	 * create a post
	 * 
	 * @param array $params
	 * @return bool
	 */
	function create_post($params)
	{
		$connection = database_connect();
		
		$query = sprintf("insert into posts
							set
								title = '%s',
								body = '%s',
								user_id = %s
						", 
						mysql_real_escape_string($params['title']),
						mysql_real_escape_string($params['body']),
						mysql_real_escape_string($params['user_id'])
						);
							
		$result = mysql_query($query);
		
		if (!$result)
		{
			return false;
		}
		else 
		{
			return true;
		}
	}
	
	function create_user($params)
	{
		$connection = database_connect();
		
		$query = "insert into users
							set
							first_name = 'liz',
							last_name = 'bowman',
							email = 'liz.bowman@windwalker.com,
							password = 'test',
							account_type = 'admin',
							created_at = NOW()
							";
	}
	
	/*
	 * updates a post
	 * 
	 * @param array $params
	 * @return bool
	 */
	function update_post($params)
	{
		$connection = database_connect();
		
		$query = sprintf("update post
				            set
				              title 	= '%s',
				              body 		= '%s',
				              user_id 	= '%s'
				              
				        	where id = %s
				        ",
						mysql_real_escape_string($params['title']),
						mysql_real_escape_string($params['body']),
						mysql_real_escape_string($params['user_id']),
						mysql_real_escape_string($params['id'])
						);
	}
	
	/*
	 * returns array of posts from database
	 * 
	 * @return array
	 */
	function find_posts()
	{
		$connection = database_connect();
		
		$query = 'select posts.title, posts.body, posts.user_id, users.first_name
				from
					posts, users
				where
					posts.user_id = users.id';
		
		$result = mysql_query($query);
		
		$number_of_posts = mysql_num_rows($result);
		
		if ($number_of_posts == 0)
		{
			return false;
		}
		
		$result = result_to_array($result); 
		
		return $result;
	}
	
	/*
	 * returns array of a single post
	 * 
	 * @return array
	 */
	function find_post($id)
	{
		$connection = database_connect();
		
		$query = sprintf("select posts.title, posts.body, posts.user_id, users.first_name
					from
						posts, users
					where
						posts.user_id = users.id and posts.id = %s
					",
					mysql_real_escape_string($id)
				);
		
		$result = mysql_query($query);
		
		$number_of_posts = mysql_num_rows($result);
		
		if ($number_of_posts == 0)
		{
			return false;
		}
		
		$row = mysql_fetch_array($result); 
		
		return $row;
	}
		
	//create_post(array('title' => 'This is my first post', 'body' => 'This is the body', 'user_id' => 1,));
	
	/*
	if (!$result)
	{
		echo mysql_error();
	}
	else 
	{
	//  $row = mysql_fetch_array($result);
	  
	//  print_r($row);
		//echo "added row";
	}
	*/          
	/*
	$query = 'select posts.title, posts.body, posts.user_id, users.first_name, users.last_name  
	          from posts, users
	          where posts.user_id = users.id
	          ';
	
	$result = mysql_query($query);
	while ($row = mysql_fetch_array($result))
	{
		echo '<h2>' . $row['title'] . '</h2>';
		echo $row['body'] . '</br>';
		echo $row['first_name'] . ' ' . $row['last_name'];
	}
	*/
	
	/*
	$post = find_posts();
	foreach ($post as $post)
	{
		echo '<h2>'. $post['title'] . '</h2>';
		echo $post['body'] . '</br>';
		echo $post['first_name'];
	}
	*/

?>