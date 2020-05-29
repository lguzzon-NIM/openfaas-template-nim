import htmlgen
import jester
from function/handler import handle

routes:
  get "/":
    resp handle("")

  get "/@name":
    resp h1(handle(@"name"))