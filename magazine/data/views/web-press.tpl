<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>{$stories[$storyNo].title|escape} | {$magazine.title|escape}</title>
		<meta property="og:title" content="{$stories[$storyNo].title|escape}">
		<meta property="og:site_name" content="{$magazine.title|escape}">
		<meta property="og:url" content="{$magazine.website|escape}">
		<meta property="og:type" content="article">
		<meta property="og:image" content="{$magazine.base|escape}cache/{$stories[$storyNo].storyCover|escape}.jpg">
		<link rel="stylesheet" href="{$magazine.base|escape}styles/web-press.css">
{foreach from=$magazine.js item=js}
		<script src="{$magazine.base|escape}js/{$js|escape}" defer></script>											
{/foreach}
	</head>
	<body>
		<div class="navigation" id="navigation">
			<div class="navigationButton" id="navigationButton">		
			</div>		
			<div class="navigationCover" style="background-image: url({$magazine.base|escape}cache/{$magazine.frontCoverImage|escape}.jpg)">		
				<div class="navigationCoverTitleBar">
					<div class="navigationCoverTitle">
						{$magazine.title|escape}
					</div>
					<div class="navigationCoverSubtitle">
						{$magazine.subtitle|escape}
					</div>
					<div class="navigationCoverIssue">
						{$magazine.issue|escape}
					</div>
				</div>
			</div>
							
{foreach from=$stories key=no item=storyItem}
	{if $storyItem.type == "story" or $storyItem.type == "advertisement"}
			<div class="navigationBG" id="navigationBG-{$no}" style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|escape}.jpg)">		
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
							style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover}.jpg)"
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

		<nav class="mainnav">
			{include file='web-press_mainnav.tpl'}		
		</nav>	
		
		<div class="header">
			<div class="headerTitleBar">
				<div class="headerTitle">
					{$magazine.title|escape}
				</div>
				<div class="headerSubtitle">
					{$magazine.subtitle|escape}
				</div>	
				<div class="headerIssue">
					{$magazine.issue|escape}
				</div>
			</div>
		</div>

		<div 
			class="storyCover" 
			style="background-image: url({$magazine.base|escape}cache/{$stories[$storyNo].storyCover|escape}.jpg); height: {$stories[$storyNo].storyCoverHeight|escape};"
		>
			<div class="storyTitleBar">
				<div class="storyTitle">
					{$stories[$storyNo].title|escape}
				</div>				
				<div class="storyAuthor">
					<img src="{$magazine.base|escape}images/vector-pen.png">
					{$stories[$storyNo].author|escape}
					<img src="{$magazine.base|escape}images/image.png">
					<a href="{$stories[$storyNo].photoSource|escape}" target="_blank">
						{$stories[$storyNo].photographer|escape} 
					</a>
					<img src="{$magazine.base|escape}images/stopwatch.png">
					{$stories[$storyNo].readTime|escape}  
				</div>
			</div>
		</div>
		
		<div class="storyOuterContent">
			<div class="storyAudio">
				<audio src="{$magazine.base|escape}audio/{$stories[$storyNo].audio|escape}" controls>
				</audio>
			</div>
			<div class="storyContent">
				{$stories[$storyNo].html}
			</div>		
			<div class="storyForm">
				<h2>Reactions</h2>			
				<form>
					<textarea class="storyFormReaction" name="reaction"></textarea>
					<input class="storyFormSubmit" type="submit" value="React">
				</form>
			</div>		
		</div>
				
		<div class="index">
			<div class="indexInner">
{if $nextStory != null}				
				
				<h2>Next</h2>
				<div class="next">				
					<div 
						class="nextInner"
						onclick="location.href='{$nextStory.url|escape}';"
						style="background-image: url({$magazine.base|escape}cache/{$nextStory.storyCover|escape}.jpg)"
					>
						<div class="nextTitleBar">
							<div class="nextTitle">
								{$nextStory.title|escape}
							</div>				
						</div>				
					</div>	 	
				</div>	
{/if}				 	
				<h2>Index</h2>
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "story"}
				<div class="indexThumb">			
					<div 
						class="indexThumbInner"
						onclick="location.href='{$storyItem.url|escape}';"
						style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|escape}.jpg)">
						<div class="indexThumbTitleBar">			
							<div class="indexThumbTitle">		
								{$storyItem.title|escape}
							</div>
						</div>
					</div>
				</div>
	{/if}
{/foreach}					

				<div class="clear">
				</div>		
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}			
				<h2>Sponsored</h2>
		{break}
	{/if}
{/foreach}
{foreach from=$stories item=storyItem}
	{if $storyItem.type == "advertisement"}
	
				<div class="navAd">
					<div
						class="navAdInner"
						onclick="location.href='{$storyItem.url|escape}';"
						style="background-image: url({$magazine.base|escape}cache/{$storyItem.storyCover|escape}.jpg)"
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
			{include file='web-press_involvement.tpl'}		
		</div>		

{*		<div class="colofon">		
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
*}
		<footer class="footer">
			<div class="footerCopyrightBar">
				{$magazine.copyright|escape}<br>
				<a href="{$magazine.website|escape}">
					{$magazine.website|escape}
				</a>
			</div>
		</footer>								
	</body>
</html>

