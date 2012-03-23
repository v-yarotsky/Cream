(() ->

  cream_file = (href) ->
    $.ajax {
      type: 'GET',
      url: href,
      success: (data) ->
        $.cream(data)
    }

  links = $('link[rel="stylesheet/cream"]')
  links.each (k,v) ->
    href = $(v).attr('href')
    cream_file(href)

  $.fn.cream = (code) ->
    [parent, parser] = [$(this), new Parser()]
    $.each parser.run(code), (selector, styles) ->
      $.each styles, (i) ->
        style = styles[i].match(/[^.].+/)[0]
        parent.find(selector).addClass style

  $.cream = (code) ->
    $('body').cream(code)

)(jQuery)
