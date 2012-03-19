root = exports ? window

class Parser
  run: (code) ->
    code = @split(code)
    new Root(code).build()

  split: (code) ->
    code.replace /\s*/g, ''

root.Parser = Parser
