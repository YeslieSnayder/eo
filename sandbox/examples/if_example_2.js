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
    this.eq = function (val) {
        return new _bool(this.val === val)
    }
    this.toString = this.val.toString()
    return this
}
function _string(val) {
    this.val = val
    this.toString = this.val
    return this
}
function _bool(val) {
    this.val = val
    this.if = function (if_true, if_false) {
        return this.val ? if_true : if_false
    }
    return this
}



/**
 * The main object that a parser will create
 */
function app() {
    this.num = new _int(5)
    obj(this.num)
    return this
}
function obj(num) {
    this.num = num
    stdout(
        sprintf(
            new _string("Your Number: %d\n"),
            this.num.eq(new _int(0)).if(new _int(0), new _int(1))
        )
    )
    return this
}

app()

/*  Result
Your Number: 1
 */