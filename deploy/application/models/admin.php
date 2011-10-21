<?php

    /*
     * Create a user account
     *
     * @param array $params
     */
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
		     if (isset($_SESSION['user']))
		     {
			$_SESSION['user'] = null;
		     }
		     
		     return false;
		}

		$row = mysql_fetch_array($result);

		$_SESSION['user'] = $row;

		return true;
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
     * returns array of portfolio_pieces from database
     *
     * @return array
     */
    function find_portfolio_pieces()
    {
         $connection = database_connect();

         $query = 'select 
                    portfolio_pieces.id,
                    portfolio_pieces.title,
                    portfolio_pieces.media,
                    portfolio_pieces.description,
                    portfolio_pieces.link,
                    portfolio_pieces.position,
                    portfolio_pieces.enable,
                    portfolio_pieces.user_id
               from
                    portfolio_pieces, users
               where
                    portfolio_pieces.user_id = users.id';

         $result = mysql_query($query);

         $number_of_portfolio_pieces = mysql_num_rows($result);

         if ($number_of_portfolio_pieces == 0)
         {
              return false;
         }

         $result = result_to_array($result);

         return $result;
    }

    /*
     * Returns array of a single portfolio_piece from database
     *
     * @return array
     */
    function find_portfolio_piece($id)
    {
         $connection = database_connect();

		$query = sprintf(
                    "select
                         portfolio_pieces.title,
                         portfolio_pieces.media,
                         portfolio_pieces.description,
                         portfolio_pieces.link,
                         portfolio_pieces.position,
                         portfolio_pieces.enable,
                         portfolio_pieces.user_id
					from
						portfolio_pieces, users
					where
						portfolio_pieces.user_id = users.id and portfolio_pieces.id = %s
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

    /*
	 * create a portfolio_piece
	 *
	 * @param array $params
	 * @return bool
	 */
	function create_portfolio_piece($params)
	{
		$connection = database_connect();
        
		$query = sprintf("insert into portfolio_pieces
							set
								title = '%s',
								media = '%s',
                                description = '%s',
                                link = '%s',
                                position = '%s',
                                enable = '%s',
								user_id = '%s',
                                created_at = NOW()
                                
						",
						mysql_real_escape_string($params['title']),
						mysql_real_escape_string($params['media']),
						mysql_real_escape_string($params['description']),
						mysql_real_escape_string($params['link']),
						mysql_real_escape_string($params['position']),
						mysql_real_escape_string($params['enable']),
						mysql_real_escape_string($params['user_id'])
                    );

		$result = mysql_query($query);
        
        echo '$result :: ' . $result . ' ... <br />';
        
		if (!$result)
		{
			return false;
		}
		else
		{
			return true;
		}
	}

    /*
	 * updates a portfolio_piece
	 *
	 * @param array $params
	 * @return bool
	 */
	function update_portfolio_piece($params)
	{
		$connection = database_connect();

		$query = sprintf("update portfolio_pieces
				            set
				              title 	= '%s',
				              media		= '%s',
                              description = '%s',
                              link      = '%s',
                              position  = '%s',
                              enable    = '%s',
				              user_id 	= '%s'

				        	where id = %s
				        ",
						mysql_real_escape_string($params['title']),
						mysql_real_escape_string($params['media']),
						mysql_real_escape_string($params['description']),
						mysql_real_escape_string($params['link']),
						mysql_real_escape_string($params['position']),
						mysql_real_escape_string($params['enable']),
						mysql_real_escape_string($params['user_id']),
						mysql_real_escape_string($params['id'])
						);

        $result = mysql_query($query);

        if ($result)
        {
             return true;
        }
        else
        {
             return false;
        }
	}

    /*
     * delete a portfolio_piece
     *
     * @param int $id
     * @return bool
     */
    function delete_portfolio_piece($id)
    {
         $connect = database_connect();

         $query = sprintf("delete from portfolio_pieces
                             where id = %s",
                         mysql_real_escape_string($id)
                 );
         
         $result = mysql_query($query);
         if ($result)
         {
              return true;
         }
         else
         {
              return false;
         }
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

?>