(() ->
  $.fn.cream = (code) ->
    [parent, parser] = [$(this), new Parser()]
    $.each parser.run(code), (selector, styles) ->
      parent.find(selector).addClass styles.join(' ')

  $.cream = (code) ->
    $('body').cream(code)

)(jQuery)
