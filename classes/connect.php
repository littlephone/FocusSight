<?php
/* mysqli connection part starts here... */

class connectionAttr{
	public $host = "127.0.0.1";
	public $username = "playground";
	public $password = "plyg2043";
	public $database = "focussight";

	public function __construct($host = '127.0.0.1', $username, $password, $database)
	{
	    $this->host = $host;
	    $this->username = $username;
	    $this->password = $password;
	    $this->database = $database;
	}

	function startPDOConnection(){
	  	//Connecting to the database via PDO
		try{
			$connect = new PDO("mysql:host=".$this->host.";dbname=".$this->database.";charset=utf8", $this->username, $this->password);
			//fallback for PHP prior to 5.3.6
			$connect->exec("SET names utf8");

			//To prevent character displayed incorrectly, we must use utf-8
			$connect->exec("SET CHARACTER_SET_CLIENT='utf8'");
			$connect->exec("SET CHARACTER_SET_RESULTS='utf8'");

			return $connect;
		}
		catch(PDOException $e){
			echo "Cannot connect to database. Error: ".$e->getMessage();
		}

	}
}
$attribute = new connectionAttr(DB_SERVER, DB_USERNAME, DB_PASSWORD, DATABASE);
$pdoconnect = $attribute->startPDOConnection();



/* mysqli connection part ends here...
   
   pdo connection starts...
 */

?>
