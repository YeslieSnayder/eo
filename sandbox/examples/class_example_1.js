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



/**
 * The main object that a parser will create
 */
function app() {
    this.innerClass = function(a) {
        this.a = function () {return a}
        this.b = function () {return this.a().add(new _int(20))}
        return this
    }
    this.num = function () {return new _int(10)}
    this.obj = function () {return new this.innerClass(this.num())}
    stdout.call(this,
        sprintf(
            new _string("My number : %d\nResult : %d\n"),
            this.obj().a(),
            this.obj().b()
        ))
    return this
}
app.prototype = stdout.prototype



let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()

/*  Result
My number : 10
Result : 30
 */