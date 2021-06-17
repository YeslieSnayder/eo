/**
 * Examples of functions that should be somewhere outside
 * and should be imported in this file
 */
function sprintf() {
    let str = arguments[0].toString;
    for (let i = 1; i < arguments.length; i++) {
        str = str.replace('%d', arguments[i].toString);
    }
    return _string(str);
}
function stdout(str) {
    console.log(str.toString);
    return this
}
function _int(val) {
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
function _array(args) {
    this.val = args
    this.get = function (index) {
        return this.val[index.val]
    }
    return this
}
function _string(val) {
    this.val = val
    this.toString = this.val
    return this
}



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
            // there is ^, EOLANG does not support same names inside objects
            // therefore it would be better to use 'this.b'
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
    stdout(
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

app()

/*  Result
Numbers: 10, 20
Addition: 30
Multiplication: 200
Subtraction (Wrong): -5
 */