root = exports ? window
Expression = require('./expression').Expression
Block = require('./block').Block

class Root extends Expression
  constructor: (content) ->
    super content
    @pattern = /.+?{.+?}/g

  build: () ->
    [ blocks, result ] = [ @content.match(@pattern), {} ]
    return result unless blocks?
    @buildBlock(result, block) for block in blocks
    result

  buildBlock: (result, block) ->
    element = new Block(block).build()
    @addElement(result, selector, styles) for selector, styles of element

  addElement: (result, selector, styles) ->
    result[selector] = if result[selector]? then result[selector].concat(styles) else styles


root.Root = Root
