/**
 * Examples of functions that should be somewhere outside
 * and should be imported in this file
 */
function _object(instance) {    // Base object
    this._instance = instance
    return this
}

function stdout(str) {
    _object.call(this, function () {console.log(str.toString)})
    return this
}
stdout.prototype = _object.prototype

function _int(val) {
    _object.call(this, val)
    this.val = val
    this.less = function (cmp) {
        return new _bool(this.val < cmp.val)
    }
    this.add = function (num) {
        return new _int(this.val + num.val)
    }
    this.toString = this.val.toString()
    return this
}
_int.prototype = _object.prototype

function _string(val) {
    _object.call(this, function () {return val})
    this.val = val
    this.toString = this.val
    return this
}
_string.prototype = _object.prototype

function _bool(val) {
    _object.call(this, function () {return val})
    this.val = val
    this.if = function (if_true, if_false) {
        return this.val ? if_true : if_false
    }
    return this
}
_bool.prototype = _object.prototype



/**
 * The main object that a parser will create
 */
function features(numOfLegs, canFly) {
    this.numOfLegs = numOfLegs
    this.canFly = canFly
    return this
}
function app() {
    this.lion = new features(new app$0$a0(), new app$0$a1())
    this.f = this.lion
    _object.call(this,
        this.f.canFly.if(
            new stdout(new _string("lion can fly")),
            new stdout(this.f.canFly.msg)
        ))
    return this
}
app.prototype = _object.prototype
function app$0$a0() {
    _int.call(this, 4)
    return this
}
app$0$a0.prototype = _int.prototype
function app$0$a1() {
    this.msg = new _string("It's a cat, cats cannot fly")
    _bool.call(this, false)
    return this
}
app$0$a1.prototype = _bool.prototype

/*
Calling functions
 */
let _application = app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()

/*  Result
It's a cat, cats cannot fly
 */