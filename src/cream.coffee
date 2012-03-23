(() ->

  creamFile = (href) ->
    $.ajax {
      type: 'GET',
      url: href,
      success: (data) ->
        $.cream(data)
    }

  links = $('link[rel="stylesheet/cream"]')
  links.each (k,v) ->
    href = $(v).attr('href')
    creamFile(href)

  addStyles = (element, styles) ->
    $.each styles, (i) ->
      style = styles[i].match(/[^.].+/)[0]
      element.addClass style

  $.fn.cream = (code) ->
    [parent, parser] = [$(this), new Parser()]
    $.each parser.run(code), (selector, styles) ->
      element = parent.find(selector)
      element.live('create', (event) ->
        addStyles $(this), styles
      )
      addStyles element, styles

  $.cream = (code) ->
    $('body').cream(code)

)(jQuery)
