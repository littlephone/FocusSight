<?php

class ImageTools{
	function compressImage($source, $destination, $quality){
		$information = getimagesize($source);

		if($information['mime'] == 'image/jpeg')
			$image = imagecreatefromjpeg($source);

		else if($information['mime'] == 'image/gif')
			$image = imagecreatefromgif($source);

		else if($information['mime'] == 'image/png'){
			$image = imagecreatefrompng($source);
		}

		imagejpeg($image, $destination, $quality);
	}

	function uploadPhoto($filearray, $directory){
		$file = basename($filearray['file']['name']);

		$imageType = strtolower(pathinfo($file, PATHINFO_EXTENSION));

		$targetfile = $directory.md5(uniqid(md5(microtime()), true)).".".$imageType;

		move_uploaded_file($filearray['file']['tmp_name'], $targetfile);

		$this->compressImage($targetfile, $targetfile, 90);

		return $targetfile;
	}
}



?>