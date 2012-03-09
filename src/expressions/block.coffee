root = exports ? window
Expression = require('./expression').Expression
Selector = require('./selector').Selector
Body = require('./body').Body

class Block extends Expression
  constructor: (content) ->
    super content
    @pattern = /(.+?){(.+)}/

  build: () ->
    result = @content.match @pattern
    selector = new Selector(result[1]).build()
    body = new Body(result[2]).build()
    @buildHash selector, body

  buildHash: (selector, body) ->
    result = {}
    result[selector] = body
    result
    
 root.Block = Block