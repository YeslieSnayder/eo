<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">{
  <xsl:apply-templates select="program/objects"/>
}</xsl:template>


    <xsl:template name="outer_object" match="program/objects">

        <!-- Outer objects (main) -->
        <xsl:for-each select="o">
            <xsl:if test="not(@ancestors)">
                <xsl:text>"</xsl:text>
                <xsl:value-of select="@original-name"/>
                <xsl:text>" : {&#13;    </xsl:text>
                <xsl:call-template name="inner_object"/>
                <xsl:text>&#13;  }</xsl:text>
                <xsl:if test="position() != last()">,&#13;  </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="inner_object">
        <xsl:for-each select="o">
            <xsl:if test="@name and not(@level)">
                <xsl:if test="position() > 1">,&#13;    </xsl:if>
                <xsl:text>"</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>" : </xsl:text>
                <xsl:call-template name="ValueTemplate"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="ValueTemplate">

        <!-- Object type -->
        <xsl:if test="o">
            <xsl:text>{&#13;      </xsl:text>
            <xsl:variable name="base_name" select="@base"/>
            <xsl:for-each select="/program/objects/o[@name=$base_name]">
                <xsl:call-template name="inner_object"/>
            </xsl:for-each>
            <xsl:text>&#13;    }</xsl:text>
        </xsl:if>

        <!-- Primitive types -->
        <xsl:if test="not(o)">
            <xsl:if test="text()">
                <xsl:choose>
                    <xsl:when test="@data = 'string'">"<xsl:value-of select="."/>"</xsl:when>
                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="not(text())">{}</xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>