<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
{foreach from=$sitemap item=item}
   <url>
      <loc>{$item.loc|escape}</loc>
      <lastmod>{$item.lastmod|escape}</lastmod>
      <changefreq>{$item.changefreq|escape}</changefreq>
      <priority>{$item.priority|escape}</priority>
   </url>
{/foreach}
</urlset> 
