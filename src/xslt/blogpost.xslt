<?xml version="1.0" encoding="utf-8" ?>
<!--
	blogpost.xslt
	
	NOTE: This transform runs on the *generated* HTML from the original Markdown file.
	It's run with `xsltproc` using the `html` option which is lax with HTML
	as input instead of XML.
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output method="html"
		indent="yes" omit-xml-declaration="yes"
		doctype-system="about:legacy-compat"
	/>

	<xsl:variable name="blog-url" select="'https://greystate.dk/log/'" />
	
	<!--
	Identity transform
	Copies elements, attributes and text verbatim, but leaves
	a backdoor open for any other template to claim "rendership".
	-->
	<xsl:template match="* | text()">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates select="* | text()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- :: 	Specific templates :: -->
	
	<!--
	Generate the `head` tag
	Handles getting the title of the post, to put in ... the <title> tag!
	Also adds the CSS files (main + Prism)
	-->
	<xsl:template match="head">
		<xsl:copy>
			<xsl:comment>This is transformed output - no need to edit</xsl:comment>
			<link rel="stylesheet" href="/assets/prism-light.css" media="(prefers-color-scheme: light)" />
			<link rel="stylesheet" href="/assets/prism-dark.css" media="(prefers-color-scheme: dark)" />
			<link rel="stylesheet" href="/assets/app.css" />

			<meta name="viewport" content="width=device-width, initial-scale=1.0" />
			<title><xsl:value-of select="../body/h1[1]" /> — Greystate Blog</title>
			
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	<!--
	The body template wraps the post content in an `article` element and adds the navbar.
	Also adds the Prism JS file.
	-->
	<xsl:template match="body">
		<xsl:copy>
			<article>
				
				<xsl:apply-templates />
				
			</article>
			
			<xsl:call-template name="navigation" />
			
			<script src="/assets/prism.min.js"></script>
		</xsl:copy>
	</xsl:template>

	<!--
	To make Prism handle the syntax highlighting we need
	to slightly modify the `class` attribute of `code` elements.
	-->
	<xsl:template match="code[@class]">
		<xsl:copy>
			<xsl:attribute name="class"><xsl:value-of select="concat('lang-', @class)" /></xsl:attribute>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	<!--
	This renders the current format of the post's publish-date.
	The markdown contains a `time` element with an additional data attribute
	holding the post's slug for use in the bookmark link.
	-->
	<xsl:template match="body/p[time]">
		<xsl:variable name="dateval" select="time/@datetime" />
		<xsl:variable name="post-slug" select="time/@data-slug" />
		
		<xsl:variable name="year" select="substring($dateval, 1, 4)" />
		<xsl:variable name="month" select="substring($dateval, 6, 2)" />
		<xsl:variable name="date" select="substring($dateval, 9, 2)" />
		<abbr class="date" title="{@datetime}">
			<a rel="bookmark" href="{$blog-url}{$year}/{$month}/{$date}/{$post-slug}/">
				<time>
					<xsl:copy-of select="time/@datetime" />
					<xsl:value-of select="normalize-space(time)" />
				</time>
			</a>
		</abbr>
	</xsl:template>
	
	<!--
	Render some navigation for the site.
	-->
	<xsl:template name="navigation">
		<nav class="navbar">
			<ul class="links">
				<li><a href="/">Frontpage</a></li>
				<li>
					<a href="/posts/">Blog</a>
					<ul class="archives">
						<li><a href="/posts/2019/">2019</a></li>
						<li><a href="/posts/2017/">2017</a></li>
						<li><a href="/posts/2008/">2008</a></li>
					</ul>
				</li>
				<li><a href="/resources/objredux/">Object Builder</a></li>
			</ul>
		</nav>
	</xsl:template>
	
</xsl:stylesheet>
