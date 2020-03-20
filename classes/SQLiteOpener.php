<?php

class SQLiteOpener{
	public $dbname;
	public $connectstr;

	public function __construct($dbname){
		//Open database
		$this->dbname = $dbname;
		try{
			$this->connectstr = new PDO("sqlite:".@$_SERVER['DOCUMENT_ROOT']."/focussight/project/".$dbname.".sqlite3");
		}catch(PDOException $e){
		}
	}

	public function getConnection(){
		return $this->connectstr;
	}

	public function initialiseDatabase(){
		$this->connectstr->exec("CREATE TABLE Member(
										memberid INTEGER PRIMARY KEY AUTOINCREMENT, 
										userid INTEGER,
										username TEXT,
										email TEXT,
										joineddate DATETIME , 
										status INTEGER(1),
										roleid INTEGER
									) ");
		$this->connectstr->exec("CREATE TABLE Notice(
										noticeid INTEGER PRIMARY KEY AUTOINCREMENT,
										postedbyuserid INTEGER,
										noticetitle TEXT, 
										noticecontent TEXT, 
										postdate DATETIME
										visible INTEGER
									)");

		/*

			STATUS = 1: completed, STATUS = 0 : not completed
		*/
		$this->connectstr->exec("CREATE TABLE Task(
										taskid INTEGER PRIMARY KEY AUTOINCREMENT,
										taskname TEXT,
										arrangetime DATETIME, 
										deadline DATETIME,
										completionrate REAL,
										status INT 
									)");


		$this->connectstr->exec("CREATE TABLE Submit(
										submitid INTEGER PRIMARY KEY AUTOINCREMENT, 
										taskid INTEGER,
										submiturl TEXT,
										submitdate DATETIME,
										submituserid INTEGER
									)");

		$this->connectstr->exec("CREATE TABLE Roles(
										roleid INTEGER PRIMARY KEY, 
										rolename TEXT,
										r_manage INTEGER DEFAULT 0,
										r_modify_group INTEGER DEFAULT 0,
										r_modify_notice INTEGER DEFAULT 0,
										r_modify_task INTEGER DEFAULT 0,
										r_submit INTEGER DEFAULT 0
									)");



		//Adding default roles

		$this->connectstr->exec("INSERT INTO Roles
						(roleid, rolename, r_manage, r_modify_group, r_modify_notice, r_modify_task, r_submit) 
				 VALUES (1, 'Administrator' , 1, 1, 1, 1, 1)");

		$this->connectstr->exec("INSERT INTO Roles
						(roleid, rolename, r_manage, r_modify_group, r_modify_notice, r_modify_task, r_submit) 
				 VALUES (81, 'Participant' , 0, 0, 0, 0, 1)");

	}

	public function closeDatabase(){
		$this->dbholder = null;
	}

	public function removeDatabase(){
		unlink(@$_SERVER['DOCUMENT_ROOT']."/focussight/projects/".$this->dbname.".sqlite");
	}

	public function __destruct(){
		$this->closeDatabase();
	}


}



?>
