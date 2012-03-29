root = exports ? window

class Parser
  run: (code) ->
    new Root(code).build()

root.Parser = Parser
