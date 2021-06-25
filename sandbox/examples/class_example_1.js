const {_seq, _bool, _char, _array, _error, _regex, stdout, _string, sprintf, _random, _numericalVal} = require('./lib/std')

function app() {
    this.innerClass = function(a) {
        this.a = function() {return a}
        this.b = function() {return this.a().add(new _numericalVal(20))}
        return this
    }
    this.num = function() {return new _numericalVal(10)}
    this.obj = function() {return this.innerClass(this.num())}
    stdout.call(this,new sprintf(new _string("My number : %d\nResult : %d\n"),this.obj().a(),this.obj().b()))
    return this
}
app.prototype = stdout.prototype


let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
