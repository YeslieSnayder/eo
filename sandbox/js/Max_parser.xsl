<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">{
        <xsl:apply-templates select="program/objects/*"/>
        }
    </xsl:template>

    <xsl:template name="object" match="program/objects/*">
        <xsl:if test="((@name) and not (@level))">"<xsl:value-of select="@name"/>" : <xsl:call-template name="ValueTemplate"/></xsl:if>
    </xsl:template>

    <xsl:template name="ValueTemplate">
        <xsl:if test="o">{
            <xsl:for-each select="o">
                <xsl:call-template name="object"/>
            </xsl:for-each>},
        </xsl:if>
        <xsl:if test="not(o)">
            <xsl:if test="text()">
                <xsl:choose>
                    <xsl:when test="@data = 'string'">"<xsl:value-of select="text()"/>",
                    </xsl:when>
                    <xsl:otherwise><xsl:value-of select="text()"/>,
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="not(text())">{},
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>