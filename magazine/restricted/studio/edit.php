<?php

require_once '../../data/configs/default.php';

if(config::$enableSessions)
{
	ini_set('session.cookie_lifetime', 60 * 60 * 24 * 365);
	ini_set('session.gc-maxlifetime', 60 * 60 * 24 * 365);
	session_start();

	if(!isset($_SESSION["admin"]) || $_SESSION["admin"] <= 0)
	{
	?><!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<meta name=”robots” content=”noindex,nofollow”>
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>No access granted</title>
		</head>

		<body>
			<div lang="en">
			<h1>No access granted</h1>
			<p>
	Sorry, access denied! We understand you were hoping to gain access, but your request has been unsuccessful. Our security protocols require us to keep the door firmly shut. We thank you for your application, and hope you have a great day!</p>
			</div>	
		</body>
	</html><?php
		exit;
	}
}

require_once config::$privatePath.'tp/phpqrcode/qrlib.php';
require_once config::$privatePath.'vendor/autoload.php';

$issue = isset($_GET['issue']) ? preg_replace("/[^a-z0-9\-]/", '', strtolower($_GET['issue'])) : die('Error: Missing parameters!');

if(file_exists(config::$contentPath.'issues/'.$issue.'.json') !== true)
{
	die('Error: Wrong parameters!');
}

$story = isset($_GET['story']) ? preg_replace("/[^a-z0-9\-\_]/", '', strtolower($_GET['story'])) : die('Error: Missing parameters!');

if(file_exists(config::$contentPath.'stories/'.$story.'.md') !== true)
{
	die('Error: Wrong parameters!');
}

if($_SERVER['REQUEST_METHOD'] == 'POST')
{	
	if(isset($_POST['story']))
	{
		file_put_contents(config::$contentPath.'stories/'.$story.'.md', $_POST['story']);
		header('Location: ?issue='.urldecode($issue).'&story='.urldecode($story));
		exit();
	}
}

$parser = new \cebe\markdown\Markdown();
$json = file_get_contents(config::$contentPath.'issues/'.$issue.'.json');
$json = trim($json);
$json = json_decode($json, true);
$md = file_get_contents(config::$contentPath.'stories/'.$story.'.md');

echo '<!DOCTYPE html>';
echo '<html>';
echo '<head>';
echo '<meta charset="UTF-8">';
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">';
echo '<title>Edit md</title>';
echo '<link rel="stylesheet" href="../../shared/styles/studio.css">';
echo '</head>';
echo '<body>';

echo '<h2>'.$story.'.md</h2>';

echo '<form method="post" action="?issue='.urldecode($issue).'&amp;story='.urldecode($story).'">';
echo '<textarea name="story" style="width: 800px; height: 800px;">';
echo htmlspecialchars($md);
echo '</textarea><br>';
echo '<input type="submit" value="Submit">';
echo '</form>';

echo '</body>';
echo '</html>';

