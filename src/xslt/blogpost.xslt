<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY upper "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
	<!ENTITY lower "abcdefghijklmnopqrstuvwxyz">
]>
<!--
	blogpost.xslt
	
	NOTE: This transform runs on the *generated* HTML from the original Markdown file.
	It's run with `xsltproc` using the `html` option which is lax with HTML
	as input instead of XML.
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xhtml"
>

	<xsl:output method="html"
		indent="yes" omit-xml-declaration="yes"
		doctype-system="about:legacy-compat"
	/>

	<xsl:variable name="blog-url" select="'https://greystate.dk/log/'" />
	<xsl:variable name="data" select="//body//data[@data-slug]" />
	
	<xsl:variable name="content-id" select="'content'" />
	
	<!--
	Identity transform
	Copies elements, attributes and text verbatim, but leaves
	a backdoor open for any other template to claim "rendership".
	-->
	<xsl:template match="* | text()" priority="-1">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates select="* | text()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- :: Specific templates :: -->
	<xsl:template match="html">
		<html>
			<xsl:apply-templates />
		</html>
	</xsl:template>
	
	<!--
	Generate the `head` tag
	Handles getting the title of the post, to put in ... the <title> tag!
	Also adds the CSS files (main + Prism)
	Plus the Prism JS file (w/defer)
	-->
	<xsl:template match="head">
		<xsl:copy>
			<link rel="stylesheet" href="/assets/greystate.css" />
			<link rel="stylesheet" href="/assets/prism-light.css" media="(prefers-color-scheme: light)" />
			<link rel="stylesheet" href="/assets/prism-dark.css" media="(prefers-color-scheme: dark)" />

			<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
			<title><xsl:value-of select="../body/h1[1]" /> — Greystate Blog</title>
			
			<script src="/assets/prism.min.js" defer="defer"></script>
			
			<xsl:apply-templates />
			
		</xsl:copy>
	</xsl:template>
	
	<!--
	The body template wraps the post content in an `article` element and adds the navbar.
	-->
	<xsl:template match="body">
		<xsl:copy>
			<xsl:call-template name="RenderNavigation" />
			
			<article id="{$content-id}">
				
				<xsl:apply-templates />
				
			</article>
			
		</xsl:copy>
	</xsl:template>

	<!--
	MultiMarkdown compiles a `<figure>` from an image, but puts the alt text in the `<figcaption>`.
	
		<figure>
		<img src="/path/to/image.png" alt="Alt Text" id="ID" title="Description" />
		<figcaption>Alt Text</figcaption>
		</figure>

	We want to output a `<picture>` element with a source for *dark mode* as well.
	-->
	<xsl:template match="figure">
		<xsl:variable name="img-desc" select="img/@title" />
		<xsl:variable name="img-alt" select="img/@alt" />
		<xsl:variable name="img-src" select="img/@src" />
		<xsl:variable name="img-ext" select="substring($img-src, string-length($img-src) - 3)" />
		<xsl:variable name="img-name" select="substring($img-src, 1, string-length($img-src) - 4)" />

		<xsl:copy>
			<picture>
				<source srcset="{concat($img-name, '-dark', $img-ext)}" media="(prefers-color-scheme: dark)" />
				<img>
					<xsl:copy-of select="$img-src" />
					<xsl:copy-of select="$img-alt" />
				</img>
			</picture>
			<xsl:if test="normalize-space($img-desc)">
				<figcaption><xsl:value-of select="$img-desc" /></figcaption>
			</xsl:if>
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
	Some posts have a separate `<data data-slug="" />` element instead.
	-->
	<xsl:template match="body/p[time]">
		<xsl:variable name="dateval" select="time/@datetime" />
		<xsl:variable name="slug">
			<xsl:value-of select="time/@data-slug" />
			<xsl:if test="not(time/@data-slug)">
				<xsl:value-of select="$data/@data-slug" />
			</xsl:if>
		</xsl:variable>
		
		<xsl:variable name="year" select="substring($dateval, 1, 4)" />
		<xsl:variable name="month" select="substring($dateval, 6, 2)" />
		<xsl:variable name="date" select="substring($dateval, 9, 2)" />

		<abbr class="date" title="{$dateval}">
			<a rel="bookmark" href="{$blog-url}{$year}/{$month}/{$date}/{$slug}/">
				<time datetime="{$dateval}">
					<xsl:value-of select="normalize-space(time)" />
				</time>
			</a>
		</abbr>
	</xsl:template>
	
	<xsl:template match="h1 | h2 | h3 | h4 | h5 | h6">
		<xsl:copy>
			<xsl:attribute name="id">
				<xsl:value-of select="translate(., ' &upper;', '-&lower;')" />
			</xsl:attribute>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	<!-- Open external links in a new window -->
	<xsl:template match="a[starts-with(@href, 'http')][not(contains(@href, 'greystate.dk'))]">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:attribute name="target">_blank</xsl:attribute>
			<xsl:apply-templates select="* | text()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="p[not(normalize-space())]">
		<!-- Strip empty <p>s (or <p>s with all empty elements inside) -->
	</xsl:template>
	
	<xsl:template match="meta[@charset]"></xsl:template>
	
	<!--
	Render some navigation for the site.
	-->
	<xsl:template name="RenderNavigation">
		<a class="skipper" href="#{$content-id}">Skip to content</a>
		<nav class="navbar">
			<xsl:apply-templates select="document('../xml/navigation.xml')/navigation">
				<xsl:with-param name="currentPage" select="$data/@data-slug" />
			</xsl:apply-templates>
		</nav>
	</xsl:template>

	<xsl:include href="navigation.xslt" />

</xsl:stylesheet>
