proc handle* (param: string) : string =
    var name = " World!"
    if param != "":
        name = ", " & param & "!"
    return "Hello" & name