# PolyStat EO_JS

# Translations

It's mandatory to import 'all' built-in functions in JavaScript file and add this code at the end of file:

```bash
let _application = new 'name_of_file'()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
```

Where `'name_of_file'` is a name of current JS file (start point for a program)

## Variables

## EOlang

```bash
[] > app
  1 > i
  1.1 > f
  'A' > c
  "String" > str
  true > b
  memory > x
  (* 10 "Some" true) > arr
  obj 1 2 3 > o

```

## XML

```xml
<o line="5" name="app" original-name="app">
   <o base="org.eolang.int" data="int" line="6" name="i">1</o>
   <o base="org.eolang.float" data="float" line="7" name="f">1.1</o>
   <o base="org.eolang.char" data="char" line="8" name="c">A</o>
   <o base="org.eolang.string" data="string" line="9" name="str">String</o>
   <o base="org.eolang.bool" data="bool" line="10" name="b">true</o>
   <o base="org.eolang.memory" line="11" name="x"/>
   <o base="org.eolang.array" data="array" line="12" name="arr">
      <o base="org.eolang.int" data="int" line="12">10</o>
      <o base="org.eolang.string" data="string" line="12">Some</o>
      <o base="org.eolang.bool" data="bool" line="12">true</o>
   </o>
   <o base="obj" line="13" name="o" ref="3">
      <o base="org.eolang.int" data="int" line="13">1</o>
      <o base="org.eolang.int" data="int" line="13">2</o>
      <o base="org.eolang.int" data="int" line="13">3</o>
   </o>
</o>
```

## JavaScript

```jsx
function app() {
    this.i = function() {
return new _int(1)}
    this.f = function() {return new _float(1.1)}
    this.c = function() {return new _char('A')}
    this.str = function() {return new _string("String")}
    this.b = function() {return new _bool(true)}
    this.x = function() {return new _memory()}
    this.arr = function() {return new _array([
        new _int(10),
        new _string("Some"),
        new _bool(true)
    ])}
    this.o = function() {return new obj(
        new _int(1),
        new _int(2),
        new _int(3)
    )}
    return this
}
```

## Method call (get attribute)

## EOlang

```bash
[] > app
  1 > i
  (i.add (i.mul 4)) > newVar
  if. > res
    eq.
      5
      newVar
    "True statement"
    "False"

```

## XML

```xml
<o line="3" name="app" original-name="app">
   <o base="org.eolang.int" data="int" line="4" name="i">1</o>
   <o base=".add" line="5" method="" name="newVar">
      <o base="i" line="5" ref="4"/>
      <o base=".mul" line="5" method="">
         <o base="i" line="5" ref="4"/>
         <o base="org.eolang.int" data="int" line="5">4</o>
      </o>
   </o>
   <o base=".if" line="6" name="res">
      <o base=".eq" line="7">
         <o base="org.eolang.int" data="int" line="8">5</o>
         <o base="newVar" line="9" ref="5"/>
      </o>
      <o base="org.eolang.string" data="string" line="10">True statement</o>
      <o base="org.eolang.string" data="string" line="11">False</o>
   </o>
</o>
```

## JavaScript

```jsx
function app() {
    this.i = function() {return
        new _int(1)}
    this.newVar = function() {return
        this.i().add(
            this.i().mul(
                new _int(4)))}
    this.res = function() {return
        new _int(5)
        .eq(this.newVar())
        .if(new _string("True statement"),
            new _string("False"))}
    return this
}
```

## Object creation

## EOlang

```bash
[] > obj
  "text" > property
  [param] > innerObj
    param > num

[] > app
  obj > o
  obj.property > p1
  o.property > p2

  obj.innerObj 10 > o1
  o.innerObj 12 > o2

  o1.num > x
  o2.num > y

```

## XML

```xml
<o line="5" name="obj" original-name="obj">
   <o base="org.eolang.string" data="string" line="6" name="property">text</o>
   <o base="obj$innerObj"
      cut="1"
      line="7"
      name="innerObj"
      ref="7">
      <o as="property" base="property" level="1" ref="6"/>
   </o>
</o>
<o ancestors="1"
   line="7"
   name="obj$innerObj"
   original-name="innerObj"
   parent="obj">
   <o line="7" name="param"/>
   <o base="param" line="8" name="num" ref="7"/>
   <o level="1" line="7.6" name="property"/>
</o>
<o line="10" name="app" original-name="app">
   <o base="obj" line="11" name="o" ref="5"/>
   <o base=".property" line="12" method="" name="p1">
      <o base="obj" line="12" ref="5"/>
   </o>
   <o base=".property" line="13" method="" name="p2">
      <o base="o" line="13" ref="11"/>
   </o>
   <o base=".innerObj" line="15" method="" name="o1">
      <o base="obj" line="15" ref="5"/>
      <o base="org.eolang.int" data="int" line="15">10</o>
   </o>
   <o base=".innerObj" line="16" method="" name="o2">
      <o base="o" line="16" ref="11"/>
      <o base="org.eolang.int" data="int" line="16">12</o>
   </o>
   <o base=".num" line="18" method="" name="x">
      <o base="o1" line="18" ref="15"/>
   </o>
   <o base=".num" line="19" method="" name="y">
      <o base="o2" line="19" ref="16"/>
   </o>
</o>
```

## JavaScript

```jsx
function obj() {
    this.property = function() {return
        new _string("text")}
    this.innerObj = function(param) {
        this.param = function() {return param}
        this.num = function() {return
            this.param()}
        return this
    }
    return this
}

function app() {
    this.o = function() {return new obj()}
    this.p1 = function() {return
        new obj().property()}
    this.p2 = function() {return
        this.o().property()}
    this.o1 = function() {return
        new obj().innerObj(new _int(10))}
    this.o2 = function() {return
        this.o().innerObj(new _int(12))}
    this.x = function() {return
        this.o1().num()}
    this.y = function() {return
        this.o2().num()}
    return this
}
```

## Decorators

## EOlang

```bash
[] > app
  stdout > @
    "My text"

```

```bash
[str] > log
  stdout > @
    sprintf
      "DEBUG: %s"
      str

[str] > derived_log
  (log str) > @

[] > app
  derived_log > @
    "My message"

```

```bash
[] > log
  [msg] > print
    stdout > @
      sprintf
        "LOG: %s"
        msg

[] > app
  log.print > @
    "My message"

```

## XML

```xml
<o line="5" name="app" original-name="app">
   <o base="org.eolang.io.stdout" line="6" name="@">
      <o base="org.eolang.string" data="string" line="7">My text</o>
   </o>
</o>
```

```xml
<o line="6" name="log" original-name="log">
   <o line="6" name="str"/>
   <o base="org.eolang.io.stdout" line="7" name="@">
      <o base="org.eolang.txt.sprintf" line="8">
         <o base="org.eolang.string" data="string" line="9">DEBUG: %s</o>
         <o base="str" line="10" ref="6"/>
      </o>
   </o>
</o>
<o line="12" name="derived_log" original-name="derived_log">
   <o line="12" name="str"/>
   <o base="log" line="13" name="@" ref="6">
      <o base="str" line="13" ref="12"/>
   </o>
</o>
<o line="15" name="app" original-name="app">
   <o base="derived_log" line="16" name="@" ref="12">
      <o base="org.eolang.string" data="string" line="17">My message</o>
   </o>
</o>
```

```xml
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
```

## JavaScript

```jsx
function app() {
    stdout.call(this, new _string("My text"))
    return this
}
app.prototype = stdout.prototype
```

```jsx
function log(str) {
    this.str = function() {return str}
    stdout.call(this,
        new sprintf(
            new _string("DEBUG: %s"),
            this.str()))
    return this
}
log.prototype = stdout.prototype
function derived_log(str) {
    this.str = function() {return str}
    log.call(this,this.str())
    return this
}
derived_log.prototype = log.prototype
function app() {
    derived_log.call(this,
        new _string("My message"))
    return this
}
app.prototype = derived_log.prototype
```

```jsx
function log() {
    this.print = function(msg) {
        this.msg = function() {return msg}
        stdout.call(this,
            new sprintf(
                new _string("LOG: %s"),
                this.msg()))
        return this
    }
    this.print.prototype = stdout.prototype
    return this
}

function app() {
    log().print.call(this,
        new _string("My message"))
    return this
}
app.prototype = log().print.prototype
```