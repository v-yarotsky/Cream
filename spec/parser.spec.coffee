require './spec_helper'
Parser = require('../lib/cream.js').Parser

describe Parser, ->
  it 'empty stylesheet', ->
    result = new Parser().run('')
    expect(result).toEqual []

  it 'normal stylesheet', ->
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

  it 'Some selectors are duplicated', ->
    stylesheet = '
      #first {.container;}
      #first {.sidebar;}
    '
    json = {
      '#first' : ['.container', '.sidebar']
    }
    result = new Parser().run(stylesheet)
    expect(result).toEqual(json)

  it 'split whitespace', ->
    stylesheet = '
      #first {
          .container;
          .smth  ;
      }
    '
    split = '#first{.container;.smth;}'
    result = new Parser().split(stylesheet)
    expect(result).toEqual(split)

