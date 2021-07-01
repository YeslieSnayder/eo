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
    _memory.call(this, val)
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
_int.prototype = _memory.prototype

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

function _memory(val) {
    _object.call(this, function () {return val})
    this.val = val
    this.write = function (newVal) {
        this.val = newVal.val
        return this
    }
    this.less = function (cmp) {
        return new _bool(this.val < cmp.val)
    }
    this.add = function (num) {
        return new _int(this.val + num.val)
    }
    return this
}
_memory.prototype = _object.prototype

function _array(args) {
    _object.call(this, function () {return args})
    this.val = args
    this.get = function (index) {
        return this.val[index.val]
    }
    return this
}
_array.prototype = _object.prototype

function _seq(...args) {
    _object.call(this, function () {
        for (let i = 0; i < args.length; i++) {
            if (typeof args[i]._instance !== 'undefined')
                args[i]._instance()
        }
    })
    this.val = args
    return this
}
_seq.prototype = _object.prototype



/**
 * The main object that a parser will create
 */
function base() {
    this.get_word = function (self) {
        this.self = self
        _string.call(this, "I'm base!\n")
        return this
    }
    this.get_word.prototype = _string.prototype
    return this
}

function derived_1() {
    base.call(this)
    this.p = base()
    this.get_word = function (self) {
        this.self = self
        this.p.get_word.call(this, self)
    }
    this.get_word.prototype = this.p.get_word.prototype
    return this
}
derived_1.prototype = base.prototype

function derived_2() {
    base.call(this)
    this.get_word = function (self) {
        this.self = self
        _string.call(this, "I'm derived!\n")
        return this
    }
    this.get_word.prototype = _string.prototype
    return this
}
derived_2.prototype = base.prototype

function app(...args) {
    this._obj = this.prototype
    this.args = new _array(args)
    this.x = new _memory()
    this.objs = new _array([new base(), new derived_1(), new derived_2()])
    _seq.call(this,
        this.x.write(new _int(0)),
        this.x.less(new _int(3)).while(
            new function (parent, i) {
                this.i = function () {return i}
                _seq.call(this,
                    new stdout(
                        new sprintf(
                            "%s",
                            parent.objs.get(parent.x).get_word())),
                    parent.x.write(parent.x.add(new _int(1)))
                )
                return this
            }(this, 0)
        )
    )
    return this
}
app.prototype = _seq.prototype

function app$3$1$α1(parent, i) {
    _seq.call(this,
        new stdout(
            new sprintf(
                "%s",
                parent.objs.get(parent.x).get_word())),
        parent.x.write(parent.x.add(new _int(1)))
    )
    return this
}
app$3$1$α1.prototype = _seq.prototype



/*
Calling functions
 */
let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()

/*  Result
I'm base!
I'm base!
I'm derived!
 */