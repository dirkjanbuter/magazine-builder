<?php

require_once '../../data/configs/default.php';
require_once config::$privatePath.'tp/phpqrcode/phpqrcode.php';
require_once config::$privatePath.'vendor/autoload.php';


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

function copyDirectory($source, $destination) {
   if (!is_dir($destination)) {
      mkdir($destination, 0755, true);
   }
   $files = scandir($source);
   foreach ($files as $file) {
      if ($file !== '.' && $file !== '..') {
         $sourceFile = $source . '/' . $file;
         $destinationFile = $destination . '/' . $file;
         if (is_dir($sourceFile)) {
            copyDirectory($sourceFile, $destinationFile);
         } else {
            copy($sourceFile, $destinationFile);
         }
      }
   }
}

function copyImageToWebp($source, $target)
{
	$ext = pathinfo($source, PATHINFO_EXTENSION);
	if ($ext === 'jpg' || $ext === 'jpeg') 
	{
		$im = imagecreatefromjpeg($source);
		$webp = imagewebp($im, $target, 70);
		imagedestroy($im);
	} 
	elseif ($ext === 'png') 
	{
		$im = imagecreatefrompng($source);
		imagepalettetotruecolor($im);

		imageAlphaBlending($im, true); // alpha channel
		imageSaveAlpha($im, true); // save alpha setting

		$webp = imagewebp($im, $target);
		imagedestroy($im);
	}
}

function copyDirectoryOfImagesToWebp($source, $destination) {
   $files = scandir($source);
   foreach ($files as $file) {
      if ($file !== '.' && $file !== '..') {
         $sourceFile = $source . $file;
         $destinationFile = $destination . $file;
         if (!is_dir($sourceFile)) {
            $info = pathinfo($destinationFile); 
            copyImageToWebp($sourceFile, $info['dirname'].'/'.$info['filename'] . '.webp');
         }
      }
   }
}

function charset_base_convert ($numstring, $fromcharset, $tocharset) 
{
     $frombase = strlen($fromcharset);
     $tobase = strlen($tocharset);
     $chars = $fromcharset;
     $tostring = $tocharset;
     $number = []; 	

     $length = strlen($numstring);
     $result = '';
     for ($i = 0; $i < $length; $i++) {
         $number[$i] = strpos($chars, substr($numstring, $i, 1));
     }
     do {
         $divide = 0;
         $newlen = 0;
         for ($i = 0; $i < $length; $i++) {
             $divide = $divide * $frombase + $number[$i];
             if ($divide >= $tobase) {
                 $number[$newlen++] = (int)($divide / $tobase);
                 $divide = $divide % $tobase;
             } elseif ($newlen > 0) {
                 $number[$newlen++] = 0;
             }
         }
         $length = $newlen;
         $result = substr($tostring, $divide, 1) . $result;
     } while( $newlen != 0 );
 
     return $result;
}

function imageResize($filename, $w)
{
    $name = pathinfo($filename, PATHINFO_FILENAME);	

    if(file_exists(config::$exportPath.'images/'.$name.'.webp'))
    {
	return;
    }
    $image = @imagecreatefromstring(file_get_contents(config::$contentPath.'images/'.$filename));

    if($image === false)
    {
    	return;	
    }
		
    $oldw = imagesx($image);
    $oldh = imagesy($image);
    
    $h = (float)$w*(float)$oldh/(float)$oldw;
    
    $temp = imagecreatetruecolor(round($w), round($h));
    imagecopyresampled($temp, $image, 0, 0, 0, 0, round($w), round($h), round($oldw), round($oldh));
    imagewebp($temp, config::$exportPath.'images/'.$name.'.webp');
    return;
}

function findNextStory($json, $currentContentFile)
{
	$next = false;

	foreach($json['stories'] as $story)
	{
		switch($story['type'] ?? '')
		{
			case 'story':
			{
				if($story['contentFile'] == $currentContentFile)
				{
					$next = true; 		
				}
				else if($next)
				{
					return $story;
				}
			}
		}
	}		
	return [];
}

function findMainStory($json)
{
	$cover = false;

	foreach($json['stories'] as $story)
	{
		switch($story['type'] ?? '')
		{
			case 'story':
			{
				if(isset($story['mainStory']) && $story['mainStory'] === true)
				{
					$cover = true; 		
					return $story;
				}
			}
		}
	}		
	return [];
}

function filterNameChars($name)
{
	return str_replace([' ', ',', '\'', ':', '?', '!'], ['-', '', '', '', '', ''], strtolower($name));
}


function webUrlFromTitle($exportName , $issue, $templateName, $title)
{
	return /*config::$base . $exportName . '/' . $issue . '/web-'.$templateName.'/' .*/ filterNameChars($title) . '.html';
}

function webUrlFromTitleForQrCode($liveBase, $title)
{
	return $liveBase . filterNameChars($title) . '.html';
}


function webPathFromTitle($exportName, $issue, $templateName, $title)
{
	return config::$exportPath . $exportName . '/' . $issue . '/web-'.$templateName.'/' . filterNameChars($title) . '.html';
}


function exportLivePathFromTitle($exportLivePath, $title)
{
	return config::$doucumentRoot . $exportLivePath . filterNameChars($title) . '.html';
}



$issue = isset($_GET['issue']) ? preg_replace("/[^a-z0-9\-]/", '', strtolower($_GET['issue'])) : die('Error: Missing parameters!');
$templateName = isset($_GET['tpl']) ? preg_replace("/[^a-z0-9\-]/", '', strtolower($_GET['tpl'])) : die('Error: Missing parameters!');

$exportName = 'print';
switch($_GET['export'] ?? 'print')
{
	case 'live': $exportName = 'live'; break;
	case 'edit': $exportName = 'edit'; break;
	default: $exportName = 'print'; break;
}

if(file_exists(config::$contentPath.'issues/'.$issue.'.json') !== true)
{
	die('Error: Wrong parameters!');
}

@mkdir(config::$exportPath.$exportName.'/'.$issue.'/web-'.$templateName, 0755, true);


$parser = new \cebe\markdown\Markdown();

$maxwidth = 1024;
$json = file_get_contents(config::$contentPath.'issues/'.$issue.'.json');
$json = trim($json);
$json = json_decode($json, true);

// Locales
$language = $json['index']['language'] ?? 'en';
$translations = @file_get_contents(config::$privatePath.'locales/'.$language.'.json') ?? "";
$translations = trim($translations);
$translations = json_decode($translations, true) ?? [];
$translations = $translations['translations'] ?? [];
function dotranslate($params, $content, $smarty, &$repeat)
{
	global $translations;
	if( isset($content) ) 
	{
		return $translations[$content] ?? ($content);
	}
}

$locale = 'en_US';
if($language == 'nl')
{
	$locale = 'nl_NL';
}
$formatter = new IntlDateFormatter(
    $locale,
    IntlDateFormatter::FULL,
    IntlDateFormatter::NONE,
    'Europe/Amsterdam',
    IntlDateFormatter::GREGORIAN
);
$date = new DateTime();
$timestamp = $date->getTimestamp();	
$nowDate = $formatter->format($timestamp);

// Copy files
copyDirectory(config::$contentPath.'audio/', config::$exportPath.'audio/');
copyDirectory(config::$sharedPath.'js/', config::$exportPath.'js/');
copyDirectory(config::$sharedPath.'fonts/', config::$exportPath.'fonts/');
copyDirectoryOfImagesToWebp(config::$sharedPath.'images/', config::$exportPath.'images/');
copy(config::$sharedPath.'styles/web-'.$templateName.'.css', config::$exportPath.'styles/web-'.$templateName.'.css');
copyImageToWebp(config::$contentPath.'images/logo.png', config::$exportPath.'images/logo.webp');

// Generate QR
if(!file_exists(config::$exportPath.'images/websiteqr.webp')){
	QRcode::webp(config::$scheme.'://'.config::$liveHost.'/', config::$exportPath.'images/websiteqr.webp');
}

// index.php
$home = 'index.html';

imageResize($json['index']['issueImage'], $maxwidth);
imageResize($json['index']['frontCoverImage'], $maxwidth);

$json['index']['base'] = config::$exportBase;
$json['index']['home'] = $home;

// Parse Pre Story
$json['index']['webPreStoryHtml'] = isset($json['index']['webPreStory'])?$parser->parse($json['index']['webPreStory']):'';


$totalMinutes = 0;
for($i = 0; $i < count($json['stories']); $i++)
{
	switch($json['stories'][$i]['type'] ?? '')
	{
	case 'photoWall':
		break; 	
	case 'advertisement':
	case 'story':
	{
		// tmp fix servername
		$json['stories'][$i]['url'] = webUrlFromTitle($exportName, $issue ?? "noissue", $templateName, $json['stories'][$i]['title'] ?? 'noname');
		$mdFilename = config::$contentPath.'stories/'.$json['stories'][$i]['contentFile'];
		$mdTimeStamp = filemtime($mdFilename);
		$md = file_get_contents($mdFilename);
		$numWords = str_word_count($md);
		$minutes = round($numWords / 2.0);
		$totalMinutes += $minutes; 
		$json['stories'][$i]['numWords'] = $numWords;
		$json['stories'][$i]['minutes'] = $minutes;
		$json['stories'][$i]['readTime'] = '00:' . floor(floor($minutes/60)/10) . (floor($minutes/60)%10) . ':' . floor(round($minutes%60)/10) . (round($minutes%60)%10);
		$json['stories'][$i]['description'] = trim(substr($md,0,200));
		$json['stories'][$i]['html'] = $parser->parse($md);	
		imageResize($json['stories'][$i]['storyCover'], $maxwidth);
		
		if(!isset($json['stories'][$i]['audio']))
			$json['stories'][$i]['audio'] = null;
		
		if(isset($json['stories'][$i]['blocks']))
		{
			for($j = 0; $j < count($json['stories'][$i]['blocks']); $j++)	
			{	
				$md = file_get_contents(config::$contentPath.'blocks/'.$json['stories'][$i]['blocks'][$j]['contentFile']);
				
				if(isset($json['stories'][$i]['blocks'][$j]['cover']))
				{
					 imageResize($json['stories'][$i]['blocks'][$j]['cover'], $maxwidth);
				}
				else
				{
					$json['stories'][$i]['blocks'][$j]['cover'] = null;
				}
				
				
				$json['stories'][$i]['blocks'][$j]['html'] = $parser->parse($md);
			}
		}
		else
		{
			$json['stories'][$i]['blocks'] = [];
		}

		// Generate QR Link
		$qrLiveUrl = webUrlFromTitleForQrCode($json['index']['exportLiveBase'], $json['stories'][$i]['title'] ?? 'noname');
		$qrLinkMd5 = md5($qrLiveUrl);
		$md5Base62 = charset_base_convert($qrLinkMd5, '0123456789abcdef', '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
		$qrLinkFilename = config::$exportPath.'qrlink/'.$md5Base62.'.webp';
		$json['stories'][$i]['qrlink'] = config::$exportBase.'qrlink/'.$md5Base62.'.webp';
		if(!file_exists($qrLinkFilename)){
			QRcode::webp($qrLiveUrl, $qrLinkFilename);
		}
		
		
		// Story date
		$json['stories'][$i]['dateCreated'] = $formatter->format($mdTimeStamp);
		$json['stories'][$i]['dateTimeCreated'] = date("Y-m-d\TH:i:s",$mdTimeStamp);		
	} break;
	}
}


// total read time
$json['index']['totalMinutes'] = $totalMinutes;
$json['index']['totalReadTime'] = floor(floor($totalMinutes/3600)/10) . floor(floor($totalMinutes/3600)%10) . ':' . floor(floor(floor($totalMinutes%3600)/60)/10) . (floor(floor($totalMinutes%3600)/60)%10) . ':' . floor(round($totalMinutes%60)/10) . (round($totalMinutes%60)%10);

for($i = 0; $i < count($json['stories']); $i++)
{

	//
	// Smarty
	//
	$smarty = new Smarty();
	$smarty->template_dir = config::$privatePath."/views/";
	$smarty->config_dir = config::$privatePath."/configs/";
	$smarty->compile_dir = config::$privatePath."/cache/";
	$smarty->caching = 0;
	$smarty->setCaching(Smarty::CACHING_LIFETIME_CURRENT);
	$smarty->error_reporting = E_ALL & ~E_NOTICE;
	$smarty->clearAllCache();

	switch($json['stories'][$i]['type'] ?? '')
	{
	case 'advertisement':
	case 'story':
	{
		
		$nextStory = findNextStory($json, $json['stories'][$i]['contentFile']);
		$mainStory = findMainStory($json);
		
		$smarty->assign([
					'stories' => $json['stories'], 
					'magazine' => $json['index'],
					'nextStory' => $nextStory,
					'mainStory' => $mainStory,
					'storyNo' => $i,
					'nowDate' => $nowDate,
					'timestamp' => $timestamp
		]);
		$smarty->registerPlugin("block","translate","dotranslate");
		
		$html = $smarty->fetch('web-'.$templateName.'.tpl');
		
		// diffrent live path
		if($exportName === 'live' && isset($json['index']['exportLivePath']))
		{
			$exportLivePath = exportLivePathFromTitle($json['index']['exportLivePath'], $json['stories'][$i]['title'] ?? 'noname');
			file_put_contents($exportLivePath, $html);
		}
		else
		{
			$webFilename = webPathFromTitle($exportName, $issue ?? "noissue", $templateName ?? "notheme", $json['stories'][$i]['title'] ?? 'noname');			
			file_put_contents($webFilename, $html);
		}	
	} break;
	}
}

// index
{

	//
	// Smarty
	//
	$smarty = new Smarty();
	$smarty->template_dir = config::$privatePath."/views/";
	$smarty->config_dir = config::$privatePath."/configs/";
	$smarty->compile_dir = config::$privatePath."/cache/";
	$smarty->caching = 0;
	$smarty->setCaching(Smarty::CACHING_LIFETIME_CURRENT);
	$smarty->error_reporting = E_ALL & ~E_NOTICE;
	$smarty->clearAllCache();

	$mainStory = findMainStory($json);
	imageResize($mainStory['mainCover'], $maxwidth);
	
	$smarty->assign([
				'stories' => $json['stories'], 
				'magazine' => $json['index'],
				'mainStory' => $mainStory,
				'storyNo' => $i,
				'nowDate' => $nowDate,
				'timestamp' => $timestamp
	]);
	$smarty->registerPlugin("block","translate","dotranslate");
	
	$html = $smarty->fetch('web-'.$templateName.'_index.tpl');
	
	// diffrent live path
	if($exportName === 'live' && isset($json['index']['exportLivePath']))
	{
		$exportLivePath = exportLivePathFromTitle($json['index']['exportLivePath'], 'index');
		file_put_contents($exportLivePath, $html);
	}
	else
	{
		$webFilename = webPathFromTitle($exportName, $issue ?? "noissue", $templateName ?? "notheme", 'index');			
		file_put_contents($webFilename, $html);
	}	
}

echo 'OK!';

