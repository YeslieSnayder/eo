/**
 * Examples of functions that should be somewhere outside
 * and should be imported in this file
 */
function _object(instance) {    // Base object
    this._instance = instance
    return this
}

function sprintf() {
    let str = arguments[0].toString;
    for (let i = 1; i < arguments.length; i++) {
        str = str.replace(/%d|%s/, arguments[i].toString);
    }
    return _string(str);
}

function stdout(str) {
    _object.call(this, function () {console.log(str.toString)})
    return this
}
stdout.prototype = _object.prototype

function _int(val) {
    _object.call(this, val)
    this.val = val
    this.add = function (val) {
        return new _int(this.val + val.val)
    }
    this.mul = function (val) {
        return new _int(this.val * val.val)
    }
    this.sub = function (val) {
        return new _int(this.val - val.val)
    }
    this.eq = function (val) {
        return new _bool(this.val === val)
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
    this.while = function (action) {
        return new _object(new function () {
            while (this.val) {
                action()
            }})
    }
    return this
}
_bool.prototype = _object.prototype



/**
 * The main object that a parser will create
 */
function app() {
    this.num = new _int(5)
    obj.call(this, this.num)
    return this
}
app.prototype = obj.prototype
function obj(num) {
    this.num = num
    stdout.call(this,
        sprintf(
            new _string("Your Number: %d\n"),
            this.num.eq(new _int(0)).if(new _int(0), new _int(1))
        )
    )
    return this
}
obj.prototype = stdout.prototype



let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()

/*  Result
Your Number: 1
 */