
// Somewhere outside functions
function sprintf() {
    let str = arguments[0];
    for (let i = 1; i < arguments.length; i++) {
        str = str.replace('%d', arguments[i]);
    }
    return str;
}
function stdout(str) {
    console.log(str);
}
function get(arr, index) {
    return arr[index]
}



function app() {
    this.innerClass = function(a, b) {
        this.a = a
        this.b = b
        this.first = a + b
        this.innerInnerClass = function(c) {
            this.c = c
            this.second = c * b
            return this
        }
        return this
    }
    this.someClass = function() {
        this.innerInnerClass = function(...args) {
            this.args = args
            this.second = get(args, 0) - 15
            return this
        }
        return this
    }
    this.num1 = 10
    this.num2 = 20
    this.s = this.innerClass(this.num1, this.num2)
    this.inner1 = this.s.innerInnerClass(this.num1).second
    this.inner2 = this.someClass().innerInnerClass(this.num1).second
    stdout(
        sprintf(
            "Numbers: %d, %d\nAddition: %d\nMultiplication: %d\nSubtraction (Wrong): %d\n",
            this.num1,
            this.num2,
            this.s.first,
            this.inner1,
            this.inner2
        )
    )
}

app()

/*  Result
Numbers: 10, 20
Addition: 30
Multiplication: 200
Subtraction (Wrong): -5
 */