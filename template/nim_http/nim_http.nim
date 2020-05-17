import asynchttpserver, asyncdispatch
from function/handler import handle

var server = newAsyncHttpServer()
proc cb(req: Request) {.async.} =
  await handle(req)

waitFor server.serve(Port(8080), cb)