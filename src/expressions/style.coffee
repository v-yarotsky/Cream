class Style extends Expression
  constructor: (content) ->
    super content
    @pattern = /(.+?);/

  build: () ->
    @content.match(@pattern)[1]
