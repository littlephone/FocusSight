<?php

/*
	file: Member.php
	author: Chow Raynold
	date: 2019/5/14

*/

class Member{
	public $pdoconnect;

	public $pid;
	public $mid;
	public $status;

	public function __construct($pdoconnect){
		$this->pdoconnect = $pdoconnect;
	}

	public function getAccessibleProjectsId($userid){
		$this->mid = $userid;

		$stmt = $this->pdoconnect->prepare("SELECT pid FROM Member WHERE mid = ? AND status = 1");
		$stmt->bindValue(1, $this->mid, PDO::PARAM_INT);
		$stmt->execute();

		$resultsetarr = $stmt->fetchAll(PDO::FETCH_ASSOC);
		$pids = array();

		foreach($resultsetarr as $resultset){
			array_push($pids, $resultset['pid']);
		}

		return $pids;
	}

	public function addAuthorisedMember($pid, $userid){
		$this->pid = $pid;
		$this->mid = $userid;

		$stmt = $this->pdoconnect->prepare("INSERT INTO Member VALUES(?, ?, 1)");
		$stmt->bindValue(1, $this->pid, PDO::PARAM_INT);
		$stmt->bindValue(2, $this->mid, PDO::PARAM_INT);

		$stmt->execute();

	}
}


?>