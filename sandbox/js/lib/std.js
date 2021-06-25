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
    _object.call(this, function () {
        return args
    })
    this.val = args
    this.get = function (index) {
        return this.val[index.val]
    }

    this.empty = function () {
        return new _bool(args.empty())
    }

    this.length = function () {
        return new _numericalVal(args.length())
    }

    this.append = function (val) {
        args.push(val)
        return this
    }

    this.map = function (f) {}
    this.reduce = function (a, f) {}
    this.each = function (f) {}
    this.mapi = function (f) {}
    return this
}

function _string(val) {
    _object.call(this, function () {
        return val
    })
    this.val = val
    this.toString = this.val

    this.trim = function () {
        return new _string(this.val.trim())
    }

    this.toInt = function () {
        return new _numericalVal(Number(this.val))
    }

    this.eq = function (str) {
        return new _bool(this.val === str.val)
    }
    return this
}

function _numericalVal(val) {
    _object.call(this, val)
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
        return new _bool(this.val === val.val)
    }

    this.greater = function (val) {
        return new _bool(this.val > val.val)
    }

    this.geq = function (val) {
        return new _bool(this.val >= val.val)
    }

    this.neg = function () {
        return new _numericalVal(0 - this.val)
    }

    this.less = function (val) {
        return new _bool(this.val < val.val)
    }

    this.leq = function (val){
        return new _bool(this.val <= val.val)
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

function _bool(val) {
    _object.call(this, function () {return val})
    this.val = val

    this.if = function (if_true, if_false) {
        return this.val ? if_true : if_false
    }

    this.while = function (action) {
        return new _object(new function () {
            while (val) {
                action()
            }})
    }

    this.not = function () {
        return new _bool(!this.val)
    }

    this.and = function (...bool_objs) {
        let res = this.val
        for (let c in bool_objs) {
            res = res && c.val
            if (!res) break
        }
        return new _bool(res)
    }

    this.or = function (...bool_objs) {
        let res = this.val
        for (let c in bool_objs) {
            res = res || c.val
            if (res) break
        }
        return new _bool(res)
    }

    this.toString = this.val.toString()
    return this
}

function _char(val) {
    _object.call(this, function () {return val})
    this.val = val

    this.toString = function () {
        return new _string(this.val)
    }

    this.toString = this.val
    return this
}

function _seq(...steps) {
    _object.call(this, function () {
        for (let i = 0; i < steps.length; i++) {
            if (typeof steps[i]._instance !== 'undefined')
                steps[i]._instance()
        }
    })
    this.val = steps
    return this
}

function _random() {return this}

function _error(msg) {
    this.val = msg
    return this
}

function _regex(val) {
    this.val = val
    this.match = function (txt) {}  // return Array of matched strings
    this.matches = function (txt) {}
    return this
}



module.exports = {
    _seq: _seq,
    _bool: _bool,
    _char: _char,
    _array: _array,
    _error: _error,
    _regex: _regex,
    stdout: stdout,
    _string: _string,
    sprintf: sprintf,
    _random: _random,
    _numericalVal: _numericalVal
}