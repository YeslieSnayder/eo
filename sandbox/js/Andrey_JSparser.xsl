<?xml version="1.0" encoding="UTF-8"?>
<program ms="100"
         name="app.eo"
         time="2021-06-24T17:30:53.016790Z"
         version="0.1.25">
   <listing>+package sandbox

+alias stdout org.eolang.io.stdout
+alias sprintf org.eolang.txt.sprintf

[] &gt; log
  [msg] &gt; print
    stdout &gt; @
      sprintf
        "LOG: %s"
        msg

[] &gt; app
  log.print &gt; @
    "My message"
&lt;EOF&gt;</listing>
   <errors/>
   <sheets>
      <sheet>not-empty-atoms</sheet>
      <sheet>middle-varargs</sheet>
      <sheet>duplicate-names</sheet>
      <sheet>many-free-attributes</sheet>
      <sheet>broken-aliases</sheet>
      <sheet>duplicate-aliases</sheet>
      <sheet>one-body</sheet>
      <sheet>same-line-names</sheet>
      <sheet>self-naming</sheet>
      <sheet>add-refs</sheet>
      <sheet>wrap-method-calls</sheet>
      <sheet>vars-float-up</sheet>
      <sheet>add-refs</sheet>
      <sheet>resolve-aliases</sheet>
      <sheet>resolve-aliases</sheet>
      <sheet>add-default-package</sheet>
      <sheet>broken-refs</sheet>
      <sheet>unknown-names</sheet>
      <sheet>noname-attributes</sheet>
      <sheet>duplicate-names</sheet>
      <sheet>data-objects</sheet>
      <sheet>globals-to-abstracts</sheet>
      <sheet>remove-refs</sheet>
      <sheet>abstracts-float-up</sheet>
      <sheet>remove-levels</sheet>
      <sheet>add-refs</sheet>
      <sheet>fix-missed-names</sheet>
      <sheet>broken-refs</sheet>
   </sheets>
   <metas>
      <meta line="1">
         <head>package</head>
         <tail>sandbox</tail>
         <part>sandbox</part>
      </meta>
      <meta line="3">
         <head>alias</head>
         <tail>stdout org.eolang.io.stdout</tail>
         <part>stdout</part>
         <part>org.eolang.io.stdout</part>
      </meta>
      <meta line="4">
         <head>alias</head>
         <tail>sprintf org.eolang.txt.sprintf</tail>
         <part>sprintf</part>
         <part>org.eolang.txt.sprintf</part>
      </meta>
   </metas>
   <objects>
      <o line="6" name="log" original-name="log">
         <o base="log$print" cut="0" line="7" name="print" ref="7"/>
      </o>
      <o ancestors="1"
         line="7"
         name="log$print"
         original-name="print"
         parent="log">
         <o line="7" name="msg"/>
         <o base="org.eolang.io.stdout" line="8" name="@">
            <o base="org.eolang.txt.sprintf" line="9">
               <o base="org.eolang.string" data="string" line="10">LOG: %s</o>
               <o base="msg" line="11" ref="7"/>
            </o>
         </o>
      </o>
      <o line="13" name="app" original-name="app">
         <o base=".print" line="14" method="" name="@">
            <o base="log" line="14" ref="6"/>
            <o base="org.eolang.string" data="string" line="15">My message</o>
         </o>
      </o>
   </objects>
</program>
