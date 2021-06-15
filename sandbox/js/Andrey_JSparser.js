function app() {
    function innerClass(param = 'Class parameters for app$innerClass') {
        this.a = a
        this.b = 
            
            20
         
    }
    this.num = 10
    this.obj = new innerClass('Call parameters')
    stdout('Call parameters')
}

app()