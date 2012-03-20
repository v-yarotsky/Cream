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
      parent.find(selector).addClass styles.join(' ')

  $.cream = (code) ->
    $('body').cream(code)

)(jQuery)
