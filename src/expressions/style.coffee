root = exports ? window
Expression = require('./expression').Expression

class Style extends Expression
  constructor: (content) ->
    super content
    @pattern = /(.+?);/g

  build: () ->
    @content

root.Style = Style