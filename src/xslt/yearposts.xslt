<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

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
			<xsl:value-of select="format-number(substring-before(@slug, '/'), '##.')" />
			<xsl:text> </xsl:text>
			<a>
				<xsl:attribute name="href">
					<xsl:text>/</xsl:text>
					<xsl:for-each select="$ancestors">
						<xsl:value-of select="concat((@name[not(../@slug)] | @slug)[1], '/')" />
					</xsl:for-each>
				</xsl:attribute>
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>

</xsl:stylesheet>
