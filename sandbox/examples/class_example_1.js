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
        return _int(this.val + val.val)
    }
    this.toString = this.val.toString()
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
    this.innerClass = function(a) {
        this.a = a
        this.b = this.a.add(new _int(20))
        return this
    }
    this.num = new _int(10)
    this.obj = new this.innerClass(this.num)
    stdout(
        sprintf(
            new _string("My number : %d\nResult : %d\n"),
            obj.a,
            obj.b
        )
    )
    return this
}

app()

/*  Result
My number : 10
Result : 30
 */