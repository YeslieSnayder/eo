<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">{
        <xsl:apply-templates select="program/objects"/>
        }
    </xsl:template>

    <xsl:template match="objects">
        <xsl:for-each select="o">
            <xsl:if test="(not (@parent))">
                <xsl:if test="position()>1">
                    <xsl:text>,&#13;    </xsl:text>
                </xsl:if>
               <xsl:text>"</xsl:text>
               <xsl:value-of select="@original-name"/>
               <xsl:text>" : {&#13;    </xsl:text>
               <xsl:call-template name="insideObjects"/>
               <xsl:text>}</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="insideObjects">
        <xsl:for-each select="o">
        <xsl:if test="@name and not (@level)">
            <xsl:if test="position() > 1">
                <xsl:text>,&#13;    </xsl:text>
            </xsl:if>
            <xsl:text>"</xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text>" : </xsl:text>
            <xsl:call-template name="valueTemplate"/>
        </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template name="valueTemplate">

        <xsl:if test="@cut">
            <xsl:text>{&#13;    </xsl:text>
            <xsl:variable name="base" select="@base"/>
            <xsl:for-each select="/program/objects/o[@name=$base]">
                <xsl:call-template name="insideObjects"/>
            </xsl:for-each>
            <xsl:text>&#13;    }</xsl:text>
        </xsl:if>

        <xsl:if test="not(@cut)">
            <xsl:choose>
                <xsl:when test="@data = 'string'">
                    <xsl:text>"</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>"</xsl:text>
                </xsl:when>
                <xsl:when test="not(text())">
                    <xsl:text>{}</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>