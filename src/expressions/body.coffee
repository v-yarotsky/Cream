root = exports ? window
Expression = require('./expression').Expression
Style = require('./style').Style

class Body extends Expression
  constructor: (content) ->
    super content
    @pattern = /.+?;/g

  build: () ->
    [ styles, result ] = [ @content.match(@pattern), [] ]
    @buildStyle(result, style) for style in styles
    result

  buildStyle: (result, style) ->
    result.push new Style(style).build()
    
root.Body = Body
