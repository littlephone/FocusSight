<?php

include_once @$_SERVER['DOCUMENT_ROOT']."/focussight/classes/SQLiteOpener.php";
include_once @$_SERVER['DOCUMENT_ROOT']."/classes/Users.php";
include_once @$_SERVER['DOCUMENT_ROOT']."/focussight/classes/Member.php";

class Project{
	public $pdoconnect;
	public $pid;
	public $pname;
	public $manager_id;
	public $requirements;
	public $status;
	public $introduction;
	public $project_snapshot;
	public $accept;
	public $recommended;
	public $rules;

	public function __construct($pdoconnect){
		$this->pdoconnect = $pdoconnect;
	}
	
	public function getRecommendedProject(){
	
	
	}
	public function getProjectByPid($pid){
		$this->pid =$pid;
		$stmt = $this->pdoconnect->prepare("SELECT * FROM Project WHERE pid = ?");
		$stmt->bindValue(1, $this->pid, PDO::PARAM_INT);
		$stmt->execute();

		$resultset = $stmt->fetch(PDO::FETCH_ASSOC);

		$this->pname = $resultset["pname"];
		$this->manager_id = $resultset["manager_id"];
		$this->requirements = $resultset["requirements"];
		$this->status = $resultset["status"];
		$this->introduction = $resultset["introduction"];
		$this->project_snapshot = $resultset["project_snapshot"];
		$this->accept = $resultset["accepting_members"];

	}
	public function searchProject($keyword){
		$param = "%{$keyword}%";
		$stmt = $this->pdoconnect->prepare("SELECT * FROM Project WHERE pname LIKE ?");
		$stmt->bindParam(1, $param, PDO::PARAM_STR);
		$stmt->execute();
		return $stmt;

	}

	public function createProject($pname, $manager_id, $requirements, $status, $introduction, $project_snapshot, $accept, $rules){
		$this->pname = $pname;
		$this->manager_id = $manager_id;
		$this->requirements = $requirements;
		$this->status = $status;
		$this->introduction = $introduction;
		$this->project_snapshot = $project_snapshot;
		$this->accept = $accept;
		$this->rules = $rules;

		//1. Create Project Record
		try{
			$this->pdoconnect->beginTransaction();

			$stmt = $this->pdoconnect->prepare("INSERT INTO Project
								(pname, manager_id, requirements, status, introduction , project_snap_shot, 
								accepting_members , participating_rules, create_date)
								VALUES (?,?,?,?,?,?,?,?, CURRENT_TIMESTAMP())");

			$stmt->bindValue(1, $this->pname, PDO::PARAM_STR);
			$stmt->bindValue(2, $this->manager_id, PDO::PARAM_INT);
			$stmt->bindValue(3, $this->requirements, PDO::PARAM_INT);
			$stmt->bindValue(4, $this->status, PDO::PARAM_STR);
			$stmt->bindValue(5, $this->introduction, PDO::PARAM_STR);
			$stmt->bindValue(6, $this->project_snapshot, PDO::PARAM_STR);
			$stmt->bindValue(7, $this->accept, PDO::PARAM_INT);
			$stmt->bindValue(8, $this->rules, PDO::PARAM_STR);

			$stmt->execute();

			$this->pid = $this->pdoconnect->lastInsertId();

			$this->pdoconnect->commit();

		}catch(PDOException $e){

		}

		//2. Adding admin as authorised member 
		$member = new Member($this->pdoconnect);
		$member->addAuthorisedMember($this->pid, @$_SESSION['id']);
		//Returning pid


		return $this->pid; 
	}

	public function editProject($pid, $pname, $manager_id, $requirements, $status, $introduction, $project_snapshot, $accept, $rules){
		$this->pid = $pid;
		$this->pname = $pname;
		$this->manager_id = $manager_id;
		$this->requirements = $requirements;
		$this->status = $status;
		$this->introduction = $introduction;
		$this->project_snapshot = $project_snapshot;
		$this->accept = $accept;
		$this->rules = $rules;

		$stmt = $this->pdoconnect->prepare("
			UPDATE Project SET 
			pname = ?,
			managerid = ?,
			requirements = ?, 
			progress = ?,
			pintro = ?,
			psnapshot = ?,
			accept = ? ,
			rules = ?
			WHERE pid = ?");

		$stmt->bindValue(1, $this->pname, PDO::PARAM_STR);
		$stmt->bindValue(2, $this->managerid, PDO::PARAM_INT);
		$stmt->bindValue(3, $this->requirements, PDO::PARAM_STR);
		$stmt->bindValue(4, $this->progress, PDO::PARAM_STR);
		$stmt->bindValue(5, $this->pintro, PDO::PARAM_STR);
		$stmt->bindValue(6, $this->psnapshot, PDO::PARAM_STR);
		$stmt->bindValue(7, $this->accept, PDO::PARAM_STR);
		$stmt->bindValue(8, $this->rules, PDO::PARAM_STR);
		$stmt->bindValue(9, $this->pid, PDO::PARAM_INT);

		$stmt->execute();
	}

	public function initProjectSqlite($managerid, $pname){
		$hashkey = password_hash($managerid."-".$pname, PASSWORD_DEFAULT);
		$sqlhelper = new SQLiteOpener($hashkey);

		$sqlhelper->initialiseDatabase();

		$sqliteconnectstr = $sqlhelper->getConnection();

		$user = new Users($this->pdoconnect, "");
		$user->getUserPropById($managerid);

		$stmt = $sqliteconnectstr->prepare("
			INSERT INTO Member(userid, username, email, joineddate, status, roleid)
			VALUES (?,?,?, datetime('now'),1 ,1);
			");

		$stmt->bindValue(1, $managerid, PDO::PARAM_INT);
		$stmt->bindValue(2, $user->username, PDO::PARAM_STR);
		$stmt->bindValue(3, $user->email, PDO::PARAM_STR);

		$stmt->execute();

	}
	public function getUserProject($userid){
		$member = new Member($this->pdoconnect);
		return $member->getAccessibleProjectsId($userid);
	}
}


?>
