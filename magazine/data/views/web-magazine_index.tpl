<!DOCTYPE html>
<html lang="{$magazine.language|escape}">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>{$magazine.title|escape}</title>
		<meta property="og:title" content="{$magazine.title|escape}">
		<meta property="og:site_name" content="{$magazine.title|escape}">
{*		<meta property="og:url" content="{$stories[$storyNo].url|escape}">*}
		<meta property="og:type" content="website">
		<meta property="og:image" content="{$magazine.base|escape}cache/{$magazine.issueImage|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape}">
		<link rel="stylesheet" href="{$magazine.base|escape}styles/web-magazine.css?d={$timestamp}">
{foreach from=$magazine.js item=js}
		<script src="{$magazine.base|escape}js/{$js|escape}" defer></script>											
{/foreach}
	</head>
	<body>
		<div class="navigation" id="navigation">
			<div class="navigationButton" id="navigationButton">		
			</div>		
			<div class="navigationCover" style="background-image: url({$magazine.base|escape}cache/{$magazine.frontCoverImage|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})">						
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
			<div class="navigationBG" id="navigationBG-{$no}" style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})">		
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
							style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})"
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
		
		<header class="header" onclick="location.href='{$magazine.home|escape}';">
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

		<div class="mainStory">				
			<a 
				href="{$mainStory.url|escape}"
				class="mainStoryInner"
				onclick="location.href='{$mainStory.url|escape}';"
				style="background-image: url({$magazine.base|escape}cache/{$mainStory.mainCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})"
			>				
				<div class="mainStoryTitleBar">
					<h2 class="mainStoryTitle">
						{$mainStory.title|escape}
					</h2>
					<p class="mainStoryContent">
						{$mainStory.description|escape}...
					</p>						
				</div>				
			</a>	 	
		</div>	

		<div class="index">
			<div class="indexInner">				
								 	
				<h2>{translate}Table of Contents{/translate}</h2>
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "story"}
				<div class="indexThumb">			
					<a 
						href="{$storyItem.url|escape}" 
						class="indexThumbInner"
						style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})">
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
						style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|regex_replace:"/\.[a-zA-Z0-1]+$/":".webp"|escape})"
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

		<footer class="footer">
			<div class="footerCopyrightBar">
				{$magazine.copyright|escape}<br>
				<a href="{$magazine.website|escape}">
					{$magazine.website|escape}
				</a><br>
				{translate}Total reading time of all stories{/translate}: {$magazine.totalReadTime|escape}
			</div>
		</footer>
	</body>
</html>

