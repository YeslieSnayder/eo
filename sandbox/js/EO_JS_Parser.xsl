<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="yes"/>

    <!-- CONSTANT -->
    <xsl:variable name="tab" select="'    '"/>
    <xsl:variable name="line_break" select="'&#10;'"/>

    <xsl:template match="/">
        <xsl:text>const {_seq, _bool, _char, _array, _error, _regex, stdout, _string, sprintf, _random, _numericalVal} = require('./lib/std')</xsl:text>
        <xsl:value-of select="$line_break"/>
        <xsl:value-of select="$line_break"/>
        <xsl:for-each select="/program/objects/o">
            <xsl:if test="not(@parent)">
                <xsl:call-template name="object"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:value-of select="$line_break"/>
        <xsl:text>
let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
</xsl:text>
    </xsl:template>

    <xsl:template name="object">
        <xsl:variable name="base_name" select="@name"/>
        <xsl:if test="not(@parent)">
            <xsl:text>function </xsl:text>
            <xsl:call-template name="name">
                <xsl:with-param name="str" select="@original-name"/>
            </xsl:call-template>
            <xsl:text>(</xsl:text>
        </xsl:if>
        <xsl:if test="@parent">
            <xsl:text>this.</xsl:text>
            <xsl:call-template name="name">
                <xsl:with-param name="str" select="@original-name"/>
            </xsl:call-template>
            <xsl:text> = function (</xsl:text>
        </xsl:if>
        <!-- Parameters -->
        <xsl:for-each select="./o[not(@base or text() or @level)]">
            <xsl:if test="position() > 1">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:if test="@vararg">
                <xsl:text>...</xsl:text>
            </xsl:if>
            <xsl:value-of select="@name"/>
        </xsl:for-each>
        <!-- Declaration -->
        <xsl:text>) {</xsl:text>
        <xsl:value-of select="$line_break"/>
        <xsl:for-each select="./o[not(@level)]">
            <xsl:value-of select="$tab"/>
            <xsl:if test="/program/objects/o[@name=$base_name]/@ancestors">
                <xsl:call-template name="tabulation">
                    <xsl:with-param name="to" select="/program/objects/o[@name=$base_name]/@ancestors" as="integer"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:call-template name="attribute"/>
            <xsl:value-of select="$line_break"/>
        </xsl:for-each>
        <xsl:value-of select="$tab"/>
        <xsl:if test="/program/objects/o[@name=$base_name]/@ancestors">
            <xsl:call-template name="tabulation">
                <xsl:with-param name="to" select="/program/objects/o[@name=$base_name]/@ancestors" as="integer"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:text>return this</xsl:text>
        <xsl:value-of select="$line_break"/>
        <xsl:if test="/program/objects/o[@name=$base_name]/@ancestors">
            <xsl:call-template name="tabulation">
                <xsl:with-param name="to" select="/program/objects/o[@name=$base_name]/@ancestors" as="integer"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:text>}</xsl:text>
        <xsl:if test="./o[@name='@' and not(@level)]">
            <xsl:value-of select="$line_break"/>
            <xsl:if test="/program/objects/o[@name=$base_name]/@ancestors">
                <xsl:call-template name="tabulation">
                    <xsl:with-param name="to" select="/program/objects/o[@name=$base_name]/@ancestors" as="integer"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:call-template name="prototype">
                <xsl:with-param name="is_call" select="false()"/>
            </xsl:call-template>
            <xsl:value-of select="$line_break"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="attribute">
        <!-- Prototype -->
        <xsl:if test="@name='@'">
            <xsl:call-template name="prototype"/>
        </xsl:if>
        <!-- Object declaration -->
        <xsl:if test="@cut">
            <xsl:variable name="obj_name" select="@base"/>
            <xsl:for-each select="/program/objects/o[@name=$obj_name]">
                <xsl:call-template name="object"/>
            </xsl:for-each>
        </xsl:if>
        <!-- Value -->
        <xsl:if test="not(@cut or @name='@')">
            <xsl:text>this.</xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text> = function() {return </xsl:text>
            <xsl:call-template name="value"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="value">
        <xsl:param name="need_params" select="true()"/>
        <!-- Free variable -->
        <xsl:if test="not(@base or text())">
            <xsl:if test="@vararg">
                <xsl:text>new _array(</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="not(@vararg)">
                <xsl:value-of select="@name"/>
            </xsl:if>
        </xsl:if>
        <!-- Method -->
        <xsl:if test="starts-with(@base, '.')">
            <xsl:call-template name="method">
                <xsl:with-param name="need_params" select="$need_params"/>
            </xsl:call-template>
        </xsl:if>
        <!-- User-defined or variable -->
        <xsl:if test="@ref and not(@cut)">
            <xsl:variable name="obj_name" select="@base"/>
            <xsl:choose>
                <xsl:when test="/program/objects/o[@name=$obj_name]">
                    <xsl:if test="$need_params">
                        <xsl:text>new </xsl:text>
                    </xsl:if>
                    <xsl:if test="contains(@base, '$')">
                        <xsl:text>this.</xsl:text>
                    </xsl:if>
                    <xsl:call-template name="name">
                        <xsl:with-param name="str" select="/program/objects/o[@name=$obj_name]/@original-name"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="@base='@'">
                    <xsl:text>this</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>this.</xsl:text>
                    <xsl:call-template name="name">
                        <xsl:with-param name="str" select="@base"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$need_params">
                <xsl:text>(</xsl:text>
                <xsl:call-template name="parameters"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:if>
        <!-- Built-in -->
        <xsl:if test="not(starts-with(@base, '.') or @ref) and @base">
            <xsl:if test="$need_params">
                <xsl:text>new </xsl:text>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@base='^'">this</xsl:when>
                <xsl:when test="@base='org.eolang.string'">
                    <xsl:text>_string</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>("</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>")</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.char'">
                    <xsl:text>_char</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>('</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>')</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.bool'">
                    <xsl:text>_bool</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.int' or @base='org.eolang.float' or @base='org.eolang.memory'">
                    <xsl:text>_numericalVal</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.array'">
                    <xsl:text>_array</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>([</xsl:text>
                        <xsl:call-template name="parameters"/>
                        <xsl:text>])</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.io.stdout'">
                    <xsl:text>stdout</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>(</xsl:text>
                        <xsl:call-template name="parameters"/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.txt.sprintf'">
                    <xsl:text>sprintf</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>(</xsl:text>
                        <xsl:call-template name="parameters"/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@base='org.eolang.seq'">
                    <xsl:text>_seq</xsl:text>
                    <xsl:if test="$need_params">
                        <xsl:text>(</xsl:text>
                        <xsl:call-template name="parameters"/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="@base"/></xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template name="method">
        <xsl:param name="need_params" select="true()"/>
        <xsl:variable name="method_name" select="@base"/>
        <xsl:for-each select="./*">
            <xsl:if test="position()=1">
                <xsl:call-template name="value"/>
                <xsl:call-template name="name">
                    <xsl:with-param name="str" select="$method_name"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="$need_params">
            <xsl:text>(</xsl:text>
            <xsl:call-template name="parameters">
                <xsl:with-param name="exclude_first" select="true()"/>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="prototype">
        <xsl:param name="is_call" select="true()"/>
        <xsl:if test="$is_call">
            <xsl:if test="starts-with(@base, '.')">
                <xsl:call-template name="method">
                    <xsl:with-param name="need_params" select="false()"/>
                </xsl:call-template>
                <xsl:text>.call(this</xsl:text>
                <xsl:if test="./o">,</xsl:if>
                <xsl:call-template name="parameters">
                    <xsl:with-param name="exclude_first" select="true()"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="not(starts-with(@base, '.'))">
                <xsl:call-template name="value">
                    <xsl:with-param name="need_params" select="false()"/>
                </xsl:call-template>
                <xsl:text>.call(this</xsl:text>
                <xsl:if test="./o">,</xsl:if>
                <xsl:call-template name="parameters"/>
            </xsl:if>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:if test="not($is_call)">
            <xsl:if test="@parent">
                <xsl:text>this.</xsl:text>
            </xsl:if>
            <xsl:call-template name="name">
                <xsl:with-param name="str" select="@original-name"/>
            </xsl:call-template>
            <xsl:text>.prototype = </xsl:text>
            <xsl:for-each select="./o[@name='@']">
                <xsl:call-template name="value">
                    <xsl:with-param name="need_params" select="false()"/>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:text>.prototype</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="parameters">
        <xsl:param name="exclude_first" select="false()"/>
        <xsl:for-each select="./*">
            <xsl:if test="(not($exclude_first) and position() > 1) or ($exclude_first and position() > 2)">,</xsl:if>
            <xsl:if test="not($exclude_first) or ($exclude_first and position() > 1)">
                <xsl:call-template name="value"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="name">
        <xsl:param name="str" as="string"/>
        <xsl:param name="symbol" select="'-'"/>
        <xsl:param name="to" select="'_'"/>
        <xsl:if test="contains($str, $symbol)">
            <xsl:variable name="left" select="substring-before($str, $symbol)"/>
            <xsl:variable name="right" select="substring-after($str, $symbol)"/>
            <xsl:call-template name="name">
                <xsl:with-param name="str" select="concat($left, $to, $right)"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="not(contains($str, $symbol))">
            <xsl:value-of select="$str"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="tabulation">
        <xsl:param name="from" select="0" as="integer"/>
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