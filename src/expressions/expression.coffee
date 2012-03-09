root = exports ? window

class Expression
  constructor: (@content) ->

  build: () ->
    throw 'not override method!'
    
root.Expression = Expression
