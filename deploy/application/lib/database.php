<?php 
     /*
      * connects to database server and selects database
      * @return (bool) resouce
      */
     function database_connect()
     {
	$connection = mysql_connect(HOST, USERNAME, PASSWORD);

	if (!$connection)
	{
	     //die('error connecting to database server' . mysql_error());
	     return false;
	}

	if (!mysql_select_db(DATABASE, $connection))
	{
	     //die('error connection to database' . mysql_error());
	     return false;
	}

	return $connection;
     }

     /**
      * turns mysql resource into array
      *
      * @param resource $result
      * @return array
      */
     function result_to_array($result)
     {
	$result_array = array();

	for ($i = 0; $row = mysql_fetch_array($result) ; $i++)
	{
	     $result_array[$i] = $row;
	}

	return $result_array;
     }
?>