<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output method="html"
		indent="yes" omit-xml-declaration="yes"
		doctype-system="about:legacy-compat"
	/>
	
	<!-- Identity transform -->
	<xsl:template match="* | text()">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates select="* | text()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- Specific templates -->
	<xsl:template match="head">
		<xsl:copy>
			<xsl:comment>This is transformed output - no need to edit</xsl:comment>
			<link rel="stylesheet" href="/assets/app.css" />
			<link rel="stylesheet" href="/assets/prism-light.css" media="(prefers-color-scheme: light)" />
			<link rel="stylesheet" href="/assets/prism-dark.css" media="(prefers-color-scheme: dark)" />

			<meta name="viewport" content="width=device-width, initial-scale=1.0" />
			<title><xsl:value-of select="../body/h1[1]" /> — Greystate Blog</title>
			
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="body">
		<xsl:copy>
			<article>
				
				<xsl:apply-templates />
				
			</article>
			
			<script src="/assets/prism.min.js"></script>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="code[@class]">
		<xsl:copy>
			<xsl:attribute name="class"><xsl:value-of select="concat('lang-', @class)" /></xsl:attribute>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
