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
      <xsl:apply-templates select="program/objects"/>
      <xsl:value-of select="$line_break"/>
      <xsl:value-of select="$line_break"/>
      <xsl:text>
let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
</xsl:text>
   </xsl:template>


   <xsl:template name="object" match="program/objects">
      <xsl:for-each select="o">
         <xsl:if test="not(@ancestors)">
            <xsl:if test="position() > 1">
               <xsl:value-of select="$line_break"/>
            </xsl:if>
            <xsl:text>function </xsl:text>
            <xsl:value-of select="@original-name"/>
            <xsl:text>(</xsl:text>
            <xsl:call-template name="class_parameters">
               <xsl:with-param name="base_name" select="@original-name"/>
            </xsl:call-template>
            <xsl:text>) {</xsl:text>
            <xsl:call-template name="attribute"/>
            <xsl:value-of select="$line_break"/>
            <xsl:value-of select="$tab"/>
            <xsl:text>return this</xsl:text>
            <xsl:value-of select="$line_break"/>
            <xsl:text>}</xsl:text>
            <xsl:value-of select="$line_break"/>
            <xsl:if test="./o[@name='@']">
               <xsl:call-template name="decorator_prototype">
                  <xsl:with-param name="object" select="."/>
               </xsl:call-template>
            </xsl:if>
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
                  <xsl:with-param name="to" select="parent::o[@ancestors]/@ancestors" as="integer"/>
               </xsl:call-template>
            </xsl:if>
            <!-- Variable -->
            <xsl:if test="@name!='@'">
               <xsl:text>this.</xsl:text>
               <xsl:value-of select="@name"/>
               <xsl:text> = function(</xsl:text>
               <xsl:if test="@cut">
                  <xsl:call-template name="object_declaration"/>
               </xsl:if>
               <xsl:if test="not(@cut)">
                  <xsl:text>) {return </xsl:text>
                  <xsl:call-template name="ValueTemplate"/>
                  <xsl:text>}</xsl:text>
               </xsl:if>
            </xsl:if>
            <!-- Decorator -->
            <xsl:if test="@name='@'">
               <xsl:choose>
                  <xsl:when test="@base='org.eolang.io.stdout'"><xsl:text>stdout</xsl:text></xsl:when>
                  <xsl:when test="@base='org.eolang.txt.sprintf'"><xsl:text>sprintf</xsl:text></xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="prototype">
                        <xsl:with-param name="object" select="."/>
                     </xsl:call-template>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:text>.call(this,</xsl:text>
               <xsl:call-template name="call_parameters">
                  <xsl:with-param name="object" select="."/>
                  <xsl:with-param name="is_prototype" select="starts-with(@base, '.')"/>
               </xsl:call-template>
               <xsl:text>)</xsl:text>
            </xsl:if>
         </xsl:if>
      </xsl:for-each>
   </xsl:template>


   <xsl:template name="object_declaration">
      <xsl:variable name="base_name" select="@base"/>
      <xsl:call-template name="class_parameters">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
      <xsl:text>) {</xsl:text>
      <xsl:for-each select="/program/objects/o[@name=$base_name]">
         <xsl:call-template name="attribute"/>
      </xsl:for-each>
      <xsl:value-of select="$line_break"/>
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
      <xsl:if test="/program/objects/o[@name=$base_name]/o[@name='@' and not(@level)]">
         <xsl:value-of select="$line_break"/>
         <xsl:if test="/program/objects/o[@name=$base_name]/@ancestors">
            <xsl:call-template name="tabulation">
               <xsl:with-param name="to" select="/program/objects/o[@name=$base_name]/@ancestors" as="integer"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="decorator_prototype">
            <xsl:with-param name="object" select="/program/objects/o[@name=$base_name]"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>


   <xsl:template name="ValueTemplate">
      <xsl:if test="@ref">
         <xsl:variable name="base_n" select="@base"/>
         <xsl:if test="/program/objects/o[@name=$base_n]">
            <xsl:text>new </xsl:text>
         </xsl:if>
         <xsl:if test="not(/program/objects/o[@name=$base_n])">
            <xsl:text>this.</xsl:text>
         </xsl:if>
         <xsl:value-of select="@base"/>
         <xsl:text>(</xsl:text>
         <xsl:if test="text()">
            <xsl:call-template name="call_parameters">
               <xsl:with-param name="object" select="."/>
            </xsl:call-template>
         </xsl:if>
         <xsl:text>)</xsl:text>
      </xsl:if>
      <xsl:if test="not(@ref)">
         <xsl:if test="not(starts-with(@base, '.') or not(@base) or @vararg)">
            <xsl:text>new </xsl:text>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="@base='^'">this</xsl:when>
            <xsl:when test="@base='org.eolang.string'">_string("<xsl:value-of select="."/>")</xsl:when>
            <xsl:when test="@base='org.eolang.char'">_char('<xsl:value-of select="."/>')</xsl:when>
            <xsl:when test="@base='org.eolang.bool'">_bool(<xsl:value-of select="."/>)</xsl:when>
            <xsl:when test="@base='org.eolang.int' or @base='org.eolang.float' or @base='org.eolang.memory'">
               <xsl:text>_numericalVal(</xsl:text>
               <xsl:value-of select="."/>
               <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:when test="@base='org.eolang.array'">
               <xsl:text>_array([</xsl:text>
               <xsl:call-template name="call_parameters">
                  <xsl:with-param name="object" select="."/>
               </xsl:call-template>
               <xsl:text>])</xsl:text>
            </xsl:when>
            <xsl:when test="@base='org.eolang.io.stdout'">
               <xsl:text>stdout(</xsl:text>
               <xsl:call-template name="call_parameters">
                  <xsl:with-param name="object" select="."/>
               </xsl:call-template>
               <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:when test="@base='org.eolang.txt.sprintf'">
               <xsl:text>sprintf(</xsl:text>
               <xsl:call-template name="call_parameters">
                  <xsl:with-param name="object" select="."/>
               </xsl:call-template>
               <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with(@base, '.')">
               <xsl:call-template name="method">
                  <xsl:with-param name="object" select="."/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@vararg">
               <xsl:text>_array([</xsl:text>
               <xsl:value-of select="@name"/>
               <xsl:text>])</xsl:text>
            </xsl:when>
            <xsl:when test="not(@base) and not(text())">
               <xsl:value-of select="@name"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>


   <xsl:template name="method">
      <xsl:param name="object"/>
      <xsl:variable name="object_name" select="$object/@base"/>
      <xsl:for-each select="$object/*">
         <xsl:if test="position()=1">
            <xsl:call-template name="ValueTemplate"/>
            <xsl:value-of select="$object_name"/>
            <xsl:text>(</xsl:text>
         </xsl:if>
         <xsl:if test="position()>2">
            <xsl:text>,</xsl:text>
         </xsl:if>
         <xsl:if test="position()>1">
            <xsl:call-template name="ValueTemplate"/>
         </xsl:if>
      </xsl:for-each>
      <xsl:text>)</xsl:text>
   </xsl:template>


   <xsl:template name="prototype">
      <xsl:param name="object"/>
      <xsl:variable name="object_name" select="$object/@base"/>
      <xsl:if test="starts-with($object/@base, '.')">
         <xsl:for-each select="$object/*">
            <xsl:if test="position()=1">
               <xsl:if test="text()">
                  <xsl:call-template name="prototype">
                     <xsl:with-param name="object" select="."/>
                  </xsl:call-template>
               </xsl:if>
               <xsl:value-of select="@base"/>
               <xsl:text>()</xsl:text>
               <xsl:if test="not(starts-with($object_name, '.'))">
                  <xsl:text>.</xsl:text>
               </xsl:if>
            </xsl:if>
         </xsl:for-each>
      </xsl:if>
      <xsl:value-of select="$object_name"/>
   </xsl:template>


   <xsl:template name="decorator_prototype">
      <xsl:param name="object"/>
      <xsl:if test="$object/@parent">
         <xsl:text>this.</xsl:text>
      </xsl:if>
      <xsl:value-of select="@name"/>
      <xsl:text>.prototype = </xsl:text>
      <xsl:variable name="b" select="$object/o[@name='@']/@base"/>
      <xsl:choose>
         <xsl:when test="$b='org.eolang.io.stdout'"><xsl:text>stdout</xsl:text></xsl:when>
         <xsl:when test="$b='org.eolang.txt.sprintf'"><xsl:text>sprintf</xsl:text></xsl:when>
         <xsl:when test="$b='org.eolang.string'"><xsl:text>_string</xsl:text></xsl:when>
         <xsl:when test="$b='org.eolang.seq'"><xsl:text>_seq</xsl:text></xsl:when>
         <xsl:when test="$b='org.eolang.int' or $b='org.eolang.float'"><xsl:text>_numericalVal</xsl:text></xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="prototype">
               <xsl:with-param name="object" select="$object/o[@name='@']"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:text>.prototype</xsl:text>
   </xsl:template>


   <xsl:template name="call_parameters">
      <xsl:param name="object"/>
      <xsl:param name="is_prototype" select="false()"/>
      <xsl:for-each select="$object/*">
         <xsl:if test="$is_prototype">
            <xsl:if test="position() > 2">
               <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:if test="position()>1">
               <xsl:call-template name="ValueTemplate"/>
            </xsl:if>
         </xsl:if>
         <xsl:if test="not($is_prototype)">
            <xsl:if test="position() > 1">
               <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:call-template name="ValueTemplate"/>
         </xsl:if>
      </xsl:for-each>
   </xsl:template>

   <xsl:template name="class_parameters">
      <xsl:param name="base_name"/>
      <xsl:for-each select="/program/objects/o[@name=$base_name]/*">
         <xsl:if test="not(text() or @base or @level)">
            <xsl:if test="position() > 1">
               <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:value-of select="@name"/>
         </xsl:if>
      </xsl:for-each>
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