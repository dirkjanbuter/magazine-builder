<!DOCTYPE html>
<html lang="{$magazine.language|escape}">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>{$stories[$storyNo].title|escape} | {$magazine.title|escape}</title>
		<meta property="og:title" content="{$stories[$storyNo].title|escape}">
		<meta property="og:description" content="{$stories[$storyNo].description|escape}...">
		<meta property="og:site_name" content="{$magazine.title|escape}">
{*		<meta property="og:url" content="{$stories[$storyNo].url|escape}">*}
		<meta property="og:type" content="article">
		<meta property="og:image" content="{$magazine.base|escape}images/{$stories[$storyNo].storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape}">
		<link rel="stylesheet" href="{$magazine.base|escape}styles/web-magazine.css?d={$timestamp}">
{foreach from=$magazine.js item=js}
		<script src="{$magazine.base|escape}js/{$js|escape}" defer></script>											
{/foreach}
	</head>
	<body>
		<div class="navigation" id="navigation">
			<div class="navigationButton" id="navigationButton">		
			</div>		
			<div class="navigationCover" style="background-image: url({$magazine.base|escape}images/{$magazine.frontCoverImage|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})">						
				<div class="navigationCoverTitleBar">
					<div class="navigationCoverTitle">
						{$magazine.title|escape}
					</div>
					<div class="navigationCoverSubtitle">
						{$magazine.subtitle|escape}
					</div>
					<div class="navigationCoverIssue">
						{$nowDate|escape}
					</div>
				</div>
			</div>
							
{foreach from=$stories key=no item=storyItem}
	{if $storyItem.type == "story" or $storyItem.type == "advertisement"}
			<div class="navigationBG" id="navigationBG-{$no}" style="background-image: url({$magazine.base|escape}images/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})">		
{if array_key_exists('bonusStory', $storyItem) && $storyItem.bonusStory == true}
						<div class="bonusContent">
						</div>			
{/if}
				<div class="navigationBGTitleBar">
					<div class="navigationBGTitle">
						{$storyItem.title|escape}
					</div>				
				</div>		
			</div>																			
	{/if}
{/foreach}							

			<div class="navigationMain">
				<ul class="navigationIndex">		
{foreach from=$stories key=no item=storyItem}
	{if $storyItem.type == "story" or $storyItem.type == "advertisement"}
					<li>
						<a 
							href="{$storyItem.url|escape}" 
							style="background-image: url({$magazine.base|escape}images/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})"
							title="{$storyItem.title|escape}"
							onmouseover="document.getElementById('navigationBG-{$no}').className = 'navigationBG navigationBGAnimate';"
							onmouseout="document.getElementById('navigationBG-{$no}').className = 'navigationBG';"
						>
						</a>				
					</li>				
	{/if}
{/foreach}			
			
				</ul>		
			</div>		
		</div>		

		{*<nav class="mainnav">
			{include file='web-magazine_mainnav.tpl'}		
		</nav>*}	
		
		<header class="header" onclick="location.href='{$magazine.home|escape}';" style="background-image: url({$magazine.base|escape}images/logo.webp);">
			<div class="headerTitleBar">
				<div class="headerTitle">
					{$magazine.title|escape}
				</div>
				<div class="headerSubtitle">
					{$magazine.subtitle|escape}
				</div>	
				<div class="headerIssue">
					{$nowDate|escape}
				</div>
			</div>
		</header>

		<div 
			class="storyCover" 
			style="background-image: url({$magazine.base|escape}images/{$stories[$storyNo].storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape}); height: {$stories[$storyNo].storyCoverHeight|escape};"
		>
{if array_key_exists('bonusStory', $stories[$storyNo]) && $stories[$storyNo].bonusStory == true}
			<div class="bonusContent">
			</div>			
{/if}
			<div class="storyTitleBar">
				<h1 class="storyTitle">
					{$stories[$storyNo].title|escape}
				</h1>				
				<div class="storyAuthor">
					<img src="{$magazine.base|escape}images/vector-pen.webp" alt="Author icon" width="20" height="20">
					{$stories[$storyNo].author|escape}
					<img src="{$magazine.base|escape}images/image.webp" alt="Photographer icon" width="20" height="20">
					<a href="{$stories[$storyNo].photoSource|escape}" target="_blank">
						{$stories[$storyNo].photographer|escape} 
					</a>
					<img src="{$magazine.base|escape}images/stopwatch.webp" alt="Read time icon" width="20" height="20">
					{$stories[$storyNo].readTime|escape}  
				</div>
			</div>
		</div>
		<div class="storyBars">		
			<div class="storyOuterContent">
{if $stories[$storyNo].audio != null}
				<div class="storyAudio">
					<audio src="{$magazine.base|escape}audio/{$stories[$storyNo].audio|escape}" controls>
					</audio>
				</div>
{/if}				
				<div class="storyContent">
		{if array_key_exists('bonusStory', $stories[$storyNo]) && $stories[$storyNo].bonusStory eq true}
					<div id="bonusStoryContent">
						<p>{$stories[$storyNo].bonusIntro}</p>
						<p>Dit was een korte samenvatting van dit fascinerende artikel. Lees alle artikelen gratis, behalve de bonusinhoud. Deze kan je lezen door lid te worden van onze <a href="https://www.patreon.com/user/posts?u=90893961" target="_blank">Patreon</a>.</p>
					</div>
					<script>
						document.addEventListener("DOMContentLoaded", function(){
    							accessBonusStoryContent('bonusStoryContent', '{$stories[$storyNo].contentFile|escape:'quotes'}');
						});
					</script>
		{else}
					<div class="webPreStory">
						{$magazine.webPreStoryHtml}
					</div>
					{$stories[$storyNo].html}
		{/if}
				</div>		
			</div>		

			<div class="storySideBar">
{if !array_key_exists('bonusStory', $stories[$storyNo]) || $stories[$storyNo].bonusStory eq false}
	{foreach from=$stories[$storyNo].blocks item=block}
				<div class="storyBlock">
		{if $block.cover != null}
					<div 
						class="storyBlockCover" 
						style="background-image: url({$magazine.base|escape}images/{$block.cover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape});"
					>
						<div class="storyBlockCoverPhotographer">
							<img src="{$magazine.base|escape}images/image.webp" alt="Photographer icon">
							<a href="{$block.photoSource|escape}">{$block.photographer|escape}</a>
						</div>
					</div>
		{/if}
					<div class="storyBlockContent">
						<h3>{$block.title}</h3>
						{$block.html}
					</div>
				</div>		
	{/foreach}
{/if}
	
				<div class="storyInfo">
					<img class="storyQrLink" src="{$stories[$storyNo].qrlink|escape}" alt="QR-code of article" width="140" height="140">
					<time class="storyDate" datetime="{$stories[$storyNo].dateTimeCreated|escape}">{$stories[$storyNo].dateCreated|escape}</time>
				</div>
			</div>
			<div class="clear"></div>		
		</div>

		<div class="storyForm">
			{include file='web-magazine_comment.tpl'}
		</div>		
				
		<div class="index">
			<div class="indexInner">
{if $nextStory != null}				
				
				<h2>{translate}Next{/translate}</h2>
				<div class="next">				
					<a 
						href="{$nextStory.url|escape}"
						class="nextInner"
						style="background-image: url({$magazine.base|escape}images/{$nextStory.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})"
					>
{if array_key_exists('bonusStory', $nextStory) && $nextStory.bonusStory == true}
						<div class="bonusContent">
						</div>			
{/if}
					
						<div class="nextTitleBar">
							<h2 class="nextTitle">
								{$nextStory.title|escape}
							</h2>				
							<p class="nextContent">
								{$nextStory.description|escape}...
							</p>				
						</div>				
					</a>	 	
				</div>	
{/if}				 	
				<h2>{translate}Table of Contents{/translate}</h2>
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "story"}
				<div class="indexThumb">			
					<a 
						href="{$storyItem.url|escape}"
						class="indexThumbInner"
						style="background-image: url({$magazine.base|escape}images/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})">
{if array_key_exists('bonusStory', $storyItem) && $storyItem.bonusStory == true}
						<div class="bonusContent">
						</div>			
{/if}
						<div class="indexThumbTitleBar">
							<h2 class="indexThumbTitle">		
								{$storyItem.title|escape}
							</h2>
						</div>
					</a>
				</div>
	{/if}
{/foreach}					

				<div class="clear">
				</div>		
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}			
				<h2>{translate}Sponsored{/translate}</h2>
		{break}
	{/if}
{/foreach}
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}
	
				<div class="navAd">
					<div
						class="navAdInner"
						onclick="location.href='{$storyItem.url|escape}';"
						style="background-image: url({$magazine.base|escape}images/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})"
					>
						<div class="navAdTitleBar">
							<div class="navAdTitle">
								{$storyItem.title|escape}
							</div>				
						</div>				
					</div>
				</div>				
	{/if}
{/foreach}

			</div>		
		</div>		

		<div class="involvement">
			{include file='web-magazine_involvement.tpl'}		
		</div>
		
		<div class="involvementPatreon">
			{include file='web-magazine_patreon.tpl'}		
		</div>		

		<div class="colofon">
			<div class="colofonContent">

{foreach from=$magazine.colofon key=key item=values}
				<div>	
					<b>		
						{$key|escape}:		
					</b>		
	{foreach from=$values item=value}
					<i>		
						{$value|escape}		
					</i>
	{/foreach}
				</div>		
{/foreach}
			</div>		
		</div>		

		<footer class="footer">
			<div class="footerCopyrightBar">
				{$magazine.copyright|escape}<br>
				<a href="{$magazine.website|escape}">
					{$magazine.website|escape}
				</a><br>
				{translate}Total reading time of all stories{/translate}: {$magazine.totalReadTime|escape}<br>
				<a href="https://github.com/dirkjanbuter/magazine-builder">
					{translate}Powered by Magazine Builder{/translate}
				<a>			
				
			</div>
		</footer>
	</body>
</html>

