root = exports ? window
Expression = require('./expression').Expression

class Selector extends Expression
  constructor: (content) ->
    super content

  build: () ->
    @content
    
root.Selector = Selector
