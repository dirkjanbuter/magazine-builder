<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" href="{$magazineBase|escape}styles/pdf.css">
	</head>
	<body>
		<div class="pageSpacer"></div>
		<div class="frontCover" style="background-image: url({$magazineBase|escape}cache/{$magazine.frontCoverImage|escape}.jpg);">
			<div class="frontTitleBar">
				<div class="frontTitle">{$magazine.title|escape}</div>
				<div class="frontSubtitle">{$magazine.subtitle|escape}</div>
				<div class="frontIssue">{$magazine.issue|escape}</div>
			</div>
			<div class="frontThisIssue">
				<ul>
				{foreach from=$magazineStories item=story}
					{if $story.type == "story"}
					<li>
						<span>*</span>
						{$story.title}
					</li>
					{/if}
				{/foreach}
				</ul>
			</div>
		</div>
	
	{foreach from=$magazineStories item=story}
		{if $story.type == "photoWall"}
		<div class="photoWall">
			{foreach from=$story.photos item=photo}			
			<div class="photoWallPhoto" style="background-image: url({$magazineBase|escape}cache/{$photo|escape}.jpg); width: {$story.thumbWidth|escape}; height: {$story.thumbHeight|escape};">
			</div>		
			{/foreach}
		</div>		
		{elseif $story.type == "story"}
		<div class="storyCover" style="background-image: url({$magazineBase|escape}cache/{$story.storyCover}.jpg); height: {$story.storyCoverHeight}">
			<div class="storyTitleBar">
				<div class="storyTitle">
					{$story.title}
				</div>
				<div class="storyAuthor">
					<img src="{$magazineBase|escape}images/vector-pen.png"> {$story.author}
					<img src="{$magazineBase|escape}images/image.png"> {$story.photographer}
					<img src="{$magazineBase|escape}images/stopwatch.png"> {$story.time}  
				</div>
			</div>
		</div>
		<div class="storyContent">
			{$story.contentHTML}
		</div>		
	
		{elseif $story.type == "advertisement"}

	{else}

	{/if}
	{/foreach}
	
		<div class="backCover" style="background-image: url({$magazineBase|escape}cache/{$magazine.backCoverImage|escape}.jpg);">
			<div class="backCoverWebsiteQR" style="background-image: url({$magazineBase|escape}cache/websiteqr.png);">
			</div>
			<div class="backCoverCopyrightBar">
				{$magazine.copyright|escape}<br>{$magazine.website|escape}
			</div>
		</div>
	</body>
</html>
