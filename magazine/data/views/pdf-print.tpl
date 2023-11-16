<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" href="{$magazineBase|escape}styles/pdf-print.css">
	</head>
	<body>
		<div class="pageSpacer"></div>
		<div class="frontCover">
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
		{elseif $story.type == "story"}
		<div class="storyCover">
			<div class="storyTitleBar">
				<div class="storyTitle">
					{$story.title}
				</div>
				<div class="storyAuthor">
					{$story.author} | {$story.time}  
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
	
		<div class="backCover">
			<div class="backCoverWebsiteQR" style="background-image: url({$magazineBase|escape}cache/websiteqr.png);">
			</div>
			<div class="backCoverCopyrightBar">
				{$magazine.copyright|escape}<br>{$magazine.website|escape}
			</div>
		</div>
	</body>
</html>
