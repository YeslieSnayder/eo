<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">{
    <xsl:apply-templates select="program/objects"/>
}</xsl:template>

    <xsl:template name="outer_object" match="program/objects">

        <!-- Outer objects (main) -->

        <xsl:for-each select="o">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="@original-name"/>
            <xsl:text>" : {
        </xsl:text>

            <!-- Inner objects -->

            <xsl:call-template name="inner_object"/>

            <xsl:text>
    }</xsl:text><xsl:if test="position() != last()">,
    </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="inner_object">
        <xsl:for-each select="o">
            <xsl:if test="(@name and not(@level))">
                <xsl:text>"</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>" : </xsl:text>
                <xsl:call-template name="ValueTemplate"/>
                <xsl:if test="position() != last()">,
        </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="ValueTemplate">
<xsl:if test="o">

    <!-- Inner object -->

    <xsl:text>{</xsl:text>
    <xsl:for-each select="o">
        <xsl:call-template name="inner_object"/>
        <xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    <xsl:text>}</xsl:text>
</xsl:if>
<xsl:if test="not(o)">

    <!-- Primitive types -->

    <xsl:if test="text()">
        <xsl:choose>
            <xsl:when test="@data = 'string'">"<xsl:value-of select="text()"/>"</xsl:when>
            <xsl:otherwise><xsl:value-of select="text()"/></xsl:otherwise>
        </xsl:choose>
    </xsl:if>
    <xsl:if test="not(text())">{}</xsl:if>
</xsl:if>
    </xsl:template>
</xsl:stylesheet>