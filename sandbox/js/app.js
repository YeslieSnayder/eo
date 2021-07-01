const {_seq, _bool, _char, _array, _error, _regex, stdout, _string, sprintf, _random, _numericalVal} = require('./lib/std')

function app() {
    this.innerClass = function (a) {
        this.a = function() {return a}
        this.b = function() {return this.a().add(new _numericalVal(20))}
        return this
    }
    this.b = function() {return new _bool(false)}
    this.b().while.call(this,ANONYMOUS(this.innerClass(),this.b(),this.num(),this.obj()))
    this.num = function() {return new _numericalVal(10)}
    this.obj = function() {return this.innerClass(this.num())}
    return this
}
app.prototype = this.b().while.prototype


let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
