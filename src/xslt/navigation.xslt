<?xml version="1.0" encoding="utf-8" ?>
<!--
	navigation.xslt
	
	This generates the navigation for the website by transforming the
	`src/xml/navigation.xml` file.

	It is also used from within `blogpost.xslt` when generating a blogpost's HTML.
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:param name="currentPage" />

	<xsl:template match="navigation">
		<xsl:param name="currentPage" select="$currentPage" />
		<ul>
			<xsl:copy-of select="@class" />
			<xsl:apply-templates select="link[not(@hide = 'yes')]">
				<xsl:with-param name="currentPage" select="$currentPage" />
			</xsl:apply-templates>
		</ul>
	</xsl:template>
	
	<xsl:template match="link">
		<xsl:param name="currentPage" />
		<xsl:variable name="ancestors" select="ancestor-or-self::link" />
		<xsl:variable name="children" select="link[not(@hide = 'yes')]" />
		<xsl:variable name="title" select="(@slug[not(normalize-space(../@name))] | @name)[1]" />
		<li>
			<a>
				<xsl:attribute name="href">
					<xsl:text>/</xsl:text>
					<xsl:apply-templates select="$ancestors" mode="url" />
				</xsl:attribute>
				
				<xsl:if test="count($ancestors) &gt; 1">
					<xsl:attribute name="tabindex">-1</xsl:attribute>
				</xsl:if>
				
				<!--
				If there's a complete URL is specified,
				use that instead and open in a new window
				-->
				<xsl:if test="normalize-space(@url)">
					<xsl:attribute name="href"><xsl:value-of select="@url" /></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
				</xsl:if>
				
				<!-- Should we add the aria-current attribute? -->
				<xsl:if test="@slug = $currentPage">
					<xsl:attribute name="aria-current">page</xsl:attribute>
				</xsl:if>
				
				<xsl:if test="descendant::link[(@slug = $currentPage) or (substring-after(@slug, '/') = $currentPage)]">
					<xsl:attribute name="aria-current">location</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$title" />
			</a>
			<xsl:if test="$children">
				<ul class="{@subclass}">
					<xsl:apply-templates select="$children" />
				</ul>
			</xsl:if>
		</li>
	</xsl:template>
	
	<xsl:template match="link[@slug = '/']">
		<xsl:param name="currentPage" />
		<li>
			<a href="/">
				<xsl:if test="@slug = $currentPage">
					<xsl:attribute name="aria-current">page</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="link" mode="url">
		<xsl:value-of select="@slug" />
		<xsl:if test="not(@slug)">
			<xsl:value-of select="@name" />
		</xsl:if>
		<xsl:text>/</xsl:text>
	</xsl:template>

</xsl:stylesheet>
