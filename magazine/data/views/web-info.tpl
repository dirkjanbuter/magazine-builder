<!DOCTYPE html>
<html lang="{$magazine.language|escape}">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">	
		<title>{$stories[$storyNo].title|escape} | {$magazine.title|escape}</title>
		<meta property="og:title" content="{$stories[$storyNo].title|escape}">
		<meta property="og:site_name" content="{$magazine.title|escape}">
{*		<meta property="og:url" content="{$magazine.website|escape}">*}
		<meta property="og:type" content="article">
		<meta property="og:image" content="{$magazine.base|escape}cache/{$stories[$storyNo].storyCover|escape}.jpg">
		<link rel="stylesheet" href="{$magazine.base|escape}styles/web-info.css">
{foreach from=$magazine.js item=js}
		<script src="{$magazine.base|escape}js/{$js|escape}" defer></script>											
{/foreach}		
	</head>
	<body>
	
	<nav class="mainnav">
			{include file='web-info_mainnav.tpl'}		
	</nav>
		
		<header>
			<a href="/" alt="brand" class="brand">
				<img src="{$magazine.base|escape}images/logo.png" alt="logo">
				<h1>{$magazine.title|escape}</h1>
				<p>{$magazine.subtitle|escape}</p>
			</a>

			
		</header>
<main>
<div class="decoline">
</div>	
<article class="md-article">
<div class="margins">
<h2>{$stories[$storyNo].title|escape}</h2>
<p>{translate}By{/translate} {$stories[$storyNo].author|escape}, {$stories[$storyNo].readTime|escape} {translate}read time{/translate}.</p>
<img src="{$magazine.base|escape}cache/{$stories[$storyNo].storyCover|escape}.jpg" alt="{$stories[$storyNo].title|escape}">
{$stories[$storyNo].html}
{if $nextStory != null}				
<h2>{translate}Next{/translate}</h2>
<ul>
<li>
<a href="{$nextStory.url|escape}">{$nextStory.title|escape}</a>								
</li>
</ul>
{/if}				 	
<h2>{translate}Table of Contents{/translate}</h2>
<ol>
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "story"}
<li>
<a href="{$storyItem.url|escape}">{$storyItem.title|escape}</a><br>							
</li>
	{/if}
{/foreach}					
</ol>

{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}			
<h2>Sponsored</h2>
<ul>
		{break}
	{/if}
{/foreach}
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}
<li>
<a href="{$storyItem.url|escape}">{$storyItem.title|escape}</a><br>								
</li>

	{/if}
{/foreach}
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}			
</ul>
		{break}
	{/if}
{/foreach}


</div>
</article>


</main>		
		
	
		<footer>
			<div class="margins">
				{translate}This website is owned by Dirk Jan Buter. If you want to use text, images or annything else from it, please ask me first! Thank you in advance!{/translate}
			</div>
		</footer>

	</body>
</html>
