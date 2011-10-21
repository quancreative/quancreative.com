<?php

	/*
	 * redirect to address
	 * $param string $address
	 * $return redirects
	 */
	function redirect_to($address)
	{
		header('location:' . WEBSITE . APP_ROOT .'/' .  $address);
		exit;
	}
	
	/*
	 * Creates warning  msg used for errors.
	 * $param string $msg
	 * $return bool
	 */
	function flash_warning($msg)
	{
		if (!$msg) 
		{ 
			return false;
		}
		
		$_SESSION['flash']['warning'] = $msg;
		return  true;
		
	}
	
	/*
	 * Creates notice msg used for success.
	 * $param string $msg
	 * return bool
	 */
	function flash_notice($msg)
	{
		if (!$msg)
		{
			return false;
		}
		
		$_SESSION['flash']['notice'] = $msg;
		return true;
	}

    /*
     * Check for user session
     * Sends user to the login page if session cannot be found
     * @retun true or redirect
     */
    function check_authentication()
    {
         if ($_SESSION['user'])
         {
              return true;
         }
         else
         {
              redirect_to('admin');
         }
    }
?>