<?php

ini_set('memory_limit', '2048M');
ini_set('max_execution_time', '120');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

class config 
{
	public static $enableSessions = false;
	public static $doucumentRoot = "/home/dirkjan/www/magazine/";
	public static $privatePath = "/home/dirkjan/www/magazine/data/";
	public static $sharedPath = "/home/dirkjan/www/magazine/shared/";
	public static $contentPath = "/home/dirkjan/www/magazine/content/";
	public static $exportPath = "/home/dirkjan/www/magazine/export/";
	public static $scheme = "https";
	public static $host = "localhost";
	public static $sharedBase = "/magazine/shared/";
	public static $appBase = "/magazine/app/";
	public static $restrictedBase = "/magazine/restricted/";
	public static $exportBase = "/magazine/export/";
	public static $noReplyEmail = "noreply@example.com";
	public static $adminEmail = "name@example.com";
	public static $magazineHome = "/";
	public static $discordInvitationLink = 'https://example.com/code';
}



