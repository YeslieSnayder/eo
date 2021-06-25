const {_seq, _bool, _char, _array, _error, _regex, stdout, _string, sprintf, _random, _numericalVal} = require('./lib/std')

function app() {
    this.innerClass = function(a,b) {
        this.a = function() {return a}
        this.b = function() {return b}
        this.first = function() {return this.a().add(this.b())}
        this.innerInnerClass = function(c) {
            this.c = function() {return c}
            this.second = function() {return this.c().mul(new this.b())}
            return this
        }
        return this
    }
    this.someClass = function() {
        this.innerInnerClass = function(args) {
            this.args = function() {return _array([args])}
            this.second = function() {return this.args().get(new _numericalVal(0)).sub(new _numericalVal(15))}
            return this
        }
        return this
    }
    this.num1 = function() {return new _numericalVal(10)}
    this.num2 = function() {return new _numericalVal(20)}
    this.s = function() {return this.innerClass(this.num1(),this.num2())}
    this.inner1 = function() {return this.s().innerInnerClass(this.num1()).second()}
    this.inner2 = function() {return this.someClass().innerInnerClass(this.num1()).second()}
    stdout.call(this,new sprintf(new _string("Numbers: %d, %d\nAddition: %d\nMultiplication: %d\nSubtraction (Wrong): %d\n"),this.num1(),this.num2(),this.s().first(),this.inner1(),this.inner2()))
    return this
}
app.prototype = stdout.prototype


let _application = new app()
while (typeof _application._instance !== 'undefined')
    _application = _application._instance
_application()
