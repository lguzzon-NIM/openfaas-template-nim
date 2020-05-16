import asyncdispatch, asynchttpserver, strutils, tables, asyncdispatch

proc handle *(req: Request) {.async.} =
    let params = req.url.query.split("&")
    var query_params = initTable[string, string]()
    for param in params:
      if param != "":
        let r = param.split("=")
        query_params[r[0]] = r[1]
    var message = "Hello "
    if query_params.hasKey("name"):
      message = message & query_params["name"]
    else:
      message = message & "World"
    let msg = {"message": message}
    let headers = newHttpHeaders([("Content-Type","application/json")])
    await req.respond(Http200, $msg, headers)