root = exports ? window
Expression = require('./expression').Expression

class Style extends Expression
  constructor: (content) ->
    super content
    @pattern = /(.+?);/

  build: () ->
    @content.match(@pattern)[1]

root.Style = Style
