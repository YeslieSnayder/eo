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
    this.toString = this.val.toString()
    return this
}
_int.prototype = _object.prototype

function _array(args) {
    _object.call(this, function () {return args})
    this.val = args
    this.get = function (index) {
        return this.val[index.val]
    }
    return this
}
_array.prototype = _object.prototype

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
    this.innerClass = function(a, b) {
        this.a = a
        this.b = b
        this.first = this.a.add(this.b)
        this.innerInnerClass = function(c) {
            this.c = c
            this.second = this.c.mul(this.b)
            return this
        }
        return this
    }
    this.someClass = function() {
        this.innerInnerClass = function(...args) {
            this.args = new _array(args)
            this.second = this.args.get(new _int(0)).sub(new _int(15))
            return this
        }
        return this
    }
    this.num1 = new _int(10)
    this.num2 = new _int(20)
    this.s = new this.innerClass(this.num1, this.num2)
    this.inner1 = this.s.innerInnerClass(this.num1).second
    this.inner2 = this.someClass().innerInnerClass(this.num1).second
    stdout.call(this,
        sprintf(
            new _string("Numbers: %d, %d\nAddition: %d\nMultiplication: %d\nSubtraction (Wrong): %d\n"),
            this.num1,
            this.num2,
            this.s.first,
            this.inner1,
            this.inner2
        )
    )
    return this
}
app.prototype = stdout.prototype



let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()

/*  Result
Numbers: 10, 20
Addition: 30
Multiplication: 200
Subtraction (Wrong): -5
 */