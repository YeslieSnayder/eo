<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="yes"/>

    <!-- CONSTANT -->
    <xsl:variable name="tab" select="'    '"/>
    <xsl:variable name="line_break" select="'&#10;'"/>

    <xsl:template match="/">
        <xsl:apply-templates select="program/objects"/>
        <xsl:value-of select="$line_break"/>
        <xsl:value-of select="$line_break"/>
        <xsl:text>app()</xsl:text>
    </xsl:template>


    <xsl:template name="object" match="program/objects">
        <xsl:for-each select="o">
            <xsl:if test="not(@ancestors)">
                <xsl:if test="position() > 1">
                    <xsl:value-of select="$line_break"/>
                </xsl:if>
                <xsl:text>function </xsl:text>
                <xsl:value-of select="@original-name"/>
                <xsl:text>() {</xsl:text>
                <xsl:call-template name="attribute"/>
                <xsl:value-of select="$line_break"/>
                <xsl:text>}</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="attribute">
        <xsl:for-each select="o">
            <xsl:if test="@name and not(@level)">
                <xsl:value-of select="$line_break"/>
                <xsl:value-of select="$tab"/>
                <xsl:if test="parent::o[@ancestors]/@ancestors">
                    <xsl:call-template name="tabulation">
                        <xsl:with-param name="from" select="0" as="integer"/>
                        <xsl:with-param name="to" select="parent::o[@ancestors]/@ancestors" as="integer"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="ValueTemplate"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="ValueTemplate">

        <!-- Object type -->
        <xsl:if test="@cut">
            <xsl:variable name="base_name" select="@base"/>
            <xsl:text>function </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text>(</xsl:text>
            <xsl:for-each select="/program/objects/o[@name=$base_name]">
                <!-- free attributes -->
                <xsl:call-template name="class_parameters">
                    <xsl:with-param name="base_name" select="$base_name"/>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:text>) {</xsl:text>
            <xsl:for-each select="/program/objects/o[@name=$base_name]">
                <xsl:call-template name="attribute"/>
            </xsl:for-each>
            <xsl:value-of select="$line_break"/>
            <xsl:if test="/program/objects/o[@name=$base_name]/@ancestors">
                <xsl:call-template name="tabulation">
                    <xsl:with-param name="from" select="0" as="integer"/>
                    <xsl:with-param name="to" select="/program/objects/o[@name=$base_name]/@ancestors" as="integer"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:text>}</xsl:text>
        </xsl:if>

        <!-- Primitive types and methods -->
        <xsl:if test="not(@cut)">

            <xsl:if test="@name!='@'">
                <xsl:text>this.</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text> = </xsl:text>
            </xsl:if>

            <xsl:if test="@ref">
                <xsl:text>new </xsl:text>
                <xsl:value-of select="@base"/>
                <xsl:text>(</xsl:text>
                <xsl:if test="text()">
                    <xsl:call-template name="call_parameters"/>
                </xsl:if>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="text() and not(@ref)">
                <xsl:choose>
                    <xsl:when test="@data = 'string'">"<xsl:value-of select="."/>"</xsl:when>
                    <xsl:when test="@base='org.eolang.io.stdout'">
                        <xsl:text>stdout(</xsl:text>
                        <xsl:call-template name="call_parameters"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="not(text()) and not(@ref)">
                <xsl:value-of select="@name"/>
            </xsl:if>
        </xsl:if>
    </xsl:template>


    <xsl:template name="call_parameters">
        <xsl:text>'Call parameters'</xsl:text>
    </xsl:template>

    <xsl:template name="class_parameters">
        <xsl:param name="base_name"/>

        <xsl:text>param = 'Class parameters for </xsl:text>
        <xsl:value-of select="$base_name"/>
        <xsl:text>'</xsl:text>
    </xsl:template>

    <xsl:template name="tabulation">
        <xsl:param name="from"/>
        <xsl:param name="to"/>

        <xsl:if test="$from &lt; $to">
            <xsl:value-of select="$tab"/>
            <xsl:call-template name="tabulation">
                <xsl:with-param name="from" select="$from + 1"/>
                <xsl:with-param name="to" select="$to"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>