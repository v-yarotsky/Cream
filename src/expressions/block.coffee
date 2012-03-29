class Block extends Expression
  constructor: (content) ->
    super content
    @pattern = /\s*(.+?)\s*{(.+)}/

  build: () ->
    result = @content.match @pattern
    selector = new Selector(result[1]).build()
    body = new Body(result[2]).build()
    @buildHash selector, body

  buildHash: (selector, body) ->
    result = {}
    result[selector] = body
    result
