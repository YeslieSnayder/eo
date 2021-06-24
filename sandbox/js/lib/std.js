function _object(instance) {
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
    _object.call(this, function () {
        console.log(str.toString)
    })
    return this
}

function _array(args) {
    this._object.call(this, function () {
        return args
    })
    this.val = args
    this.get = function (index) {
        return this.val[index.val]
    }

    this.empty = function () {
        return args.empty()
    }

    this.length = function () {
        return args.length()
    }

    this.append = function (val) {
        return args.add(val)
    }

    this.map = function (ele, index) {

    }
    return this
}

function _string(val) {
    this._object.call(this, function () {
        return val
    })
    this.val = val
    this.toString = this.val
    return this
}

function _numericalVal(val) {
    this._object.call(this, val)
    this.val = val
    this.add = function (val) {
        return new _numericalVal(this.val + val.val)
    }
    this.mul = function (val) {
        return new _numericalVal(this.val * val.val)
    }
    this.sub = function (val) {
        return new _numericalVal(this.val - val.val)
    }

    this.eq = function (val) {
        return new _numericalVal(this.val === val.val)
    }

    this.greater = function (val) {
        return new _numericalVal(this.val > val.val)
    }
    this.geq = function (val) {
        return new _numericalVal(this.val >= val.val)
    }

    this.neg = function () {
        return new _numericalVal(0 - this.val)
    }

    this.less = function (val) {
        return new _numericalVal(this.val < val.val)
    }

    this.leq = function (val){
        return new _numericalVal(this.val <= val.val)
    }

    this.pow = function (val) {
        return new _numericalVal(Math.pow(this.val, val.val))
    }

    this.div = function (val) {
        return new _numericalVal(this.val / val.val)

    }
    this.abs = function () {
        return new _numericalVal(Math.abs(this.val))
    }

    this.signum = function () {
        if (this.val > 0) return new _numericalVal(1)
        else if (this.val < 0) return new _numericalVal(-1)
        else return new _numericalVal(0)
    }
    this.toString = this.val.toString()
    return this
}

function _bool() {
}

module.exports = {
    _object: _object,
    _array: _array,
    _string: _string,
    _numericalVal: _numericalVal
}