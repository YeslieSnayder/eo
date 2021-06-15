
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
    function innerClass(a) {
        this.a = a
        this.b = a + 20   // we can use function call: this.b = add(a, 20);
    }
    this.num = 10
    this.obj = new innerClass(this.num)

    stdout(
        sprintf(
            "My number : %d\nResult : %d\n",
            obj.a,
            obj.b)
    )
}

app()
