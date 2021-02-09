import json

type
  Message* = object
    username*: string
    message*: string


proc parseMessage*(data: string): Message =
  let dataJson = parseJson(data)
  result.username = dataJson["username"].getStr
  result.message = dataJson["message"].getStr

proc createMessage*(username, message: string): string =
  result = $(%{
    "username": %username,
    "message": %message
  }) & "\c\l"


when isMainModule:
  block:
    let data = """{"username": "John", "message": "Hi!"}"""
    let parsed = parseMessage(data)
    doAssert parsed.username == "John"
    doAssert parsed.message == "Hi!"

  block:
    let expected = """{"username":"John","message":"Hi!"}""" & "\c\l"
    doAssert createMessage("John", "Hi!") == expected
