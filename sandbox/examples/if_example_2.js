const {_seq, _bool, _char, _array, _error, _regex, stdout, _string, sprintf, _random, _numericalVal} = require('./lib/std')

function app() {
    this.num = function() {return new _numericalVal(5)}
    obj.call(this,this.num())
    return this
}
app.prototype = obj.prototype
function obj(num) {
    this.num = function() {return num}
    stdout.call(this,new sprintf(new _string("Your Number: %d\n"),this.num().eq(new _numericalVal(0)).if(new _numericalVal(0),new _numericalVal(1))))
    return this
}
obj.prototype = stdout.prototype


let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
