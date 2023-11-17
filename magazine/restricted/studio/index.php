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
			<name="viewport" content="width=device-width, initial-scale=1.0">
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

echo '<!DOCTYPE html>';
echo '<html>';
echo '<head>';
echo '<meta charset="UTF-8">';
echo '<meta name=”robots” content=”noindex,nofollow”>';
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">';
echo '<title>List</title>';
echo '<link rel="stylesheet" href="../../shared/styles/studio.css">';
echo '</head>';
echo '<body>';


if ($handle = opendir(config::$contentPath.'issues/')) {
    while (false !== ($file = readdir($handle))) {
        if ('.' === $file) continue;
        if ('..' === $file) continue;
	
	$issue = substr($file,0,strrpos($file,'.'));
	
	echo '<h2>'.htmlspecialchars($issue).'</h2>';
	echo '<ul>';	
	echo '<li>';
	echo '<a href="'.config::$exportBase.'print/'.htmlspecialchars($issue).'/web-press/">View web press</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="'.config::$exportBase.'print/'.htmlspecialchars($issue).'/web-info/">View web info</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="'.config::$exportBase.'print/'.htmlspecialchars($issue).'/web-magazine/">View web magazine</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="'.config::$exportBase.'print/'.htmlspecialchars($issue).'/pdf/press.pdf">View pdf press</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href=".'.config::$exportBase.'print/'.htmlspecialchars($issue).'/pdf/print.pdf">View pdf print</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="'.config::$exportBase.'print/'.htmlspecialchars($issue).'/txt/utf8.md">View txt print</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="web-tpl.php?issue='.urlencode($issue).'&amp;tpl=press">Export to web press</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="web-tpl.php?issue='.urlencode($issue).'&amp;tpl=info">Export to web info</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="web-tpl.php?issue='.urlencode($issue).'&amp;tpl=magazine">Export to web magazine</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="pdf-tpl.php?issue='.urlencode($issue).'&amp;tpl=press">Export to pdf press</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="pdf-tpl.php?issue='.urlencode($issue).'&amp;tpl=print">Export to pdf print</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="txt.php?issue='.urlencode($issue).'">Export to txt</a>';
	echo '</li>';
	echo '<li>';
	echo '<a href="list.php?issue='.urlencode($issue).'">Edit Stories</a>';
	echo '</li>';
	echo '</ul>';	
    }
    closedir($handle);
}

echo '<p>';
echo '<a href="users-print.php">Users (Print)</a> | <a href="users-edit.php">Users (edit)</a>';
echo '</p>';


echo '</body>';
echo '</html>';

