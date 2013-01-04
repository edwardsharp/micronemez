<?php
$type = 'GET';
$url = '';
$data = '';

if (isset($_GET['type'])) {
	$type = $_GET['type'];
}

if (isset($_GET['url'])) {
	$url = $_GET['url'];
}

if (isset($_GET['url'])) {
	$data = $_GET['data'];
}

switch ($type) {
    case 'GET':
        GETRequest($url);
        break;
    case 'POST':
        POSTRequest($url, $data);
        break;
    case 'DELETE':
        DELETERequest($url);
        break;
}

function GETRequest($url) {
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	// curl_setopt($ch, CURLOPT_HEADER, false); FIXME
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$result = curl_exec($ch);
	$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	header("HTTP/1.0 $status"); 
	curl_close($ch);
	echo $result;	

//	$content = @file_get_contents($url);
//	echo $content;
}

function POSTRequest($url, $data) {
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_POST, strlen($data));
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$result = curl_exec($ch);
	$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	header("HTTP/1.0 $status"); 
	curl_close ($ch);
	echo $result;
}

function DELETEequest($url) {
	$ch = curl_init();
	curl_setopt ($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
	$result = curl_exec($ch);
	curl_close ($ch);
	echo $result;
}
?>