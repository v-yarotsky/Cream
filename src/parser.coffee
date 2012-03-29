root = exports ? window

class Parser
  run: (code) ->
    code = @skip_newlines(code)
    new Root(code).build()

  skip_newlines: (code) ->
    code.replace /\n*/g, ''

root.Parser = Parser
