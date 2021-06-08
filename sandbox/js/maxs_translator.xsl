<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>

    <xsl:template match="args">
        <args>
            <xsl:apply-templates mode="attributes" />
            <xsl:apply-templates />
        </args>
    </xsl:template>

    <xsl:template match="text()" mode="attributes" />

    <xsl:template match="args/fld" />
    <xsl:template match="args/fld" mode="attributes">
        <xsl:attribute name="fld">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="args/child">
        <child>
            <xsl:apply-templates />
        </child>
    </xsl:template>