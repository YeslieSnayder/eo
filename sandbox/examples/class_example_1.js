
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



/**
 * The main object
 */
function app() {
    this.innerClass = function(a) {
        this.a = a
        this.b = this.a + 20   // we can use function call: this.b = add(a, 20);
        return this
    }
    this.num = 10
    this.obj = new innerClass(num)
    stdout(
        sprintf(
            "My number : %d\nResult : %d\n",
            obj.a,
            obj.b
        )
    )
}

app()

/*  Result
My number : 10
Result : 30
 */