<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output method="html" indent="yes" omit-xml-declaration="yes"
	doctype-system="about:legacy-compat"
/>

	<xsl:param name="currentYear" select="/.." />

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="normalize-space($currentYear)">
				<xsl:apply-templates select="navigation/link[@slug = 'log']/link[@name = $currentYear]" mode="heading" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="navigation/link[@slug = 'log']/link" mode="heading" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="link" mode="heading">
		<h2><xsl:value-of select="@name" /></h2>
		
		<xsl:apply-templates select="link" mode="month" />
	</xsl:template>

	<xsl:template match="link" mode="month">
		<h3><xsl:value-of select="@name" /></h3>
		<ul>
			<xsl:apply-templates select="link" mode="post" />
		</ul>
	</xsl:template>
	
	<xsl:template match="link" mode="post">
		<xsl:variable name="ancestors" select="ancestor-or-self::link" />
		<li>
			<a>
				<xsl:attribute name="href">
					<xsl:for-each select="$ancestors">
						<xsl:value-of select="concat(@slug, '/')" />
					</xsl:for-each>
				</xsl:attribute>
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

</xsl:stylesheet>
