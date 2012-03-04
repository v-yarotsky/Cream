root = exports ? window
class CleanMyHtml
  tokenize: (text)->
  test: ->
    return 1

class Tokenizer
  constructor: (text) ->
    @text = text or throw 'No source passed'
    @text = @text.replace(/\n/gm, ' ')

  getNextToken: =>
    @text = @text.replace(/\s*/m, '')
    return null if @text.length == 0

    console.log("Text after stripping whitespace: \"#{@text}\"")
    selectorRegexp = /^,?\s*([\w#.].+?)(?=\s*[,{])/
    blockStartRegexp = /^{/
    styleRegexp = /^\.[\w-]+(?=;)/
    blockEndRegexp = /^}/
     
    [content, index, type] = if match = @text.match(selectorRegexp)
      [match[1], @text.search(selectorRegexp), 'selector']
    else if match = @text.match(blockStartRegexp)
      [match[0], @text.search(blockStartRegexp), 'blockStart']
    else if match = @text.match(styleRegexp)
      [match[0], @text.search(styleRegexp), 'style']
    else if match = @text.match(blockEndRegexp)
      [match[0], @text.search(blockEndRegexp), 'blockEnd']
    else
      throw "Unexpected token near #{@text[0..20]}"

    @text = @text.slice(content.length + index)

    if type == 'style'
      @text = @text[1..-1]

    console.log("Type: #{type}\n", "Content: #{content}\n", "Remaining text: \"#{@text}\"\n")

    { type: type, content: content }

  tokenize: ->
    tokens = []
    tokens.push(token) while token = @getNextToken()
    tokens

root.Tokenizer = Tokenizer
root.CleanMyHtml = new CleanMyHtml
