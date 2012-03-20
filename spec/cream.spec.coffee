require './spec_helper'
require '../lib/cream.js'

describe 'Cream', ->
  it 'JQuery object should be defined', ->
    expect(jQuery).toBeDefined()

  it '$.cream() should work correctly', ->
    stylesheets = '
      #test {
        container;
        sidebar;
      }'

    $.cream(stylesheets)
    result = $('#test').is('.container, .sidebar')
    expect(result).toEqual(true)
