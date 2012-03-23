require './spec_helper'
require '../lib/cream.js'

describe 'Cream', ->
  it 'JQuery object should be defined', ->
    expect(jQuery).toBeDefined()

  it '$.cream() should work correctly', ->
    stylesheets = '
      #test {
        .container;
        .sidebar;
      }'

    $.cream(stylesheets)
    result = $('#test').is('.container, .sidebar')
    expect(result).toEqual(true)

  it '$.cream() should work correctly with dynamic elements', ->
    stylesheets = '
      #dynamic-element {
        .container;
        .sidebar;
      }
    '
    $.cream(stylesheets)
    element = $('<div id="dynamic-element"></div>')
    $('body').append(element)
    element.trigger('create')
    result = element.is('.container, .sidebar')
    expect(result).toEqual(true)

