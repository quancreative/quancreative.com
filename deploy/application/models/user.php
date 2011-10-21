<?php
	
	/*
	 * returns array of posts from database
	 * 
	 * @return array
	 */
	function find_user($id)
	{
		$connection = database_connect();
		
		$query = sprintf('select users.first_name, users.last_name, users.account_type
					from
						users
					where
						users.id = %s',
					mysql_real_escape_string($id)
				);
		
		$result = mysql_query($query);
		
		$number_of_users = mysql_num_rows($result);
		
		if ($number_of_users == 0)
		{
			return false;
		}
		
		$result = mysql_fetch_array($result); 
		
		return $result;
	}
	
	/*
	 * returns false if invalid login or it will set the user session and return true
	 * 
	 * @param $username, $password 
	 * @return boo
	 */
	function login($email, $password)
	{
		$connection = database_connect();
		$query = sprintf("select * from users
							where email = '%s' and
									password = '%s'	
						",
						mysql_real_escape_string($email),
						mysql_real_escape_string($password)
						);
		
		$result = mysql_query($query);
		
		$number_of_users = mysql_num_rows($result);
		
		if ($number_of_users == 0)
		{
			return false;
		}
		
		$row = mysql_free_result($result); 
		 
		$_SESSION['user'] = $row;
		
		return true;
	}
?>
