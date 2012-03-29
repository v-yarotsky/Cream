require './spec_helper'
Parser = require('../lib/cream.js').Parser

describe Parser, ->
  it 'should work with empty stylesheets', ->
    result = new Parser().run('')
    expect(result).toEqual []

  it 'should work with ordinary stylesheets', ->
    stylesheet = '
      #first {
        .container;
        .sidebar;
      }

      #second {
        .crazy;
        .perfect;
      }
    '
    json = {
      '#first' : ['.container','.sidebar'],
      '#second' : ['.crazy','.perfect']
    }
    result = new Parser().run(stylesheet)
    expect(result).toEqual(json)

  it 'should work with some duplicated selectores', ->
    stylesheet = '
      #first {.container;}
      #first {.sidebar;}
    '
    json = {
      '#first' : ['.container', '.sidebar']
    }
    result = new Parser().run(stylesheet)
    expect(result).toEqual(json)

  it 'should work with simple nested selectores', ->
    stylesheet = '
      #first { .sidebar; }
      #first .second { .container; }
    '
    json = {
      '#first' : ['.sidebar'],
      '#first .second' : ['.container']
    }
    result = new Parser().run(stylesheet)
    expect(result).toEqual(json)

