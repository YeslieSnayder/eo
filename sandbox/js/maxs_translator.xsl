<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">{
    <xsl:apply-templates select="program/objects/*"/>
}
    </xsl:template>

<xsl:template name="object" match="program/objects/*">
    <xsl:value-of select="o/@name"/> : <xsl:call-template name="Properties"/>
</xsl:template>

<xsl:template name="Properties">
    <xsl:if test="not(o)">
        <xsl:value-of select="text()"/>,
    </xsl:if>
    <xsl:if test="o">{
        <xsl:for-each select="o">
            <xsl:call-template name="object"/>
        </xsl:for-each>},
    </xsl:if>
</xsl:template>
</xsl:stylesheet>