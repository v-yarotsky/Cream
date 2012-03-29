class Body extends Expression
  constructor: (content) ->
    super @skip(content)
    @pattern = /.+?;/g

  build: () ->
    [ styles, result ] = [ @content.match(@pattern), [] ]
    @buildStyle(result, style) for style in styles
    result

  buildStyle: (result, style) ->
    result.push new Style(style).build()

  skip: (code) ->
    code.replace /\s*/g, ''
