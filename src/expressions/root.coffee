root = exports ? window
Expression = require('./expression').Expression
Block = require('./block').Block

class Root extends Expression
  constructor: (content) ->
    super content
    @pattern = /.+?{.+?}/g

  build: () ->
    [ blocks, result ] = [ @content.match(@pattern), [] ]
    return result unless blocks?
    @buildBlock(result, block) for block in blocks
    result

  buildBlock: (result, block) ->
    result.push new Block(block).build()
    
root.Root = Root
