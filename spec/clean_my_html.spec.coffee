require './spec_helper'
CleanMyHtml = require('../lib/clean_my_html').CleanMyHtml
Tokenizer = require('../lib/clean_my_html').Tokenizer

describe CleanMyHtml, ->
  it "should work at least", ->
    (expect $('body')[0]).toBeDefined()
    (expect CleanMyHtml.test(1)).toEqual(1)

describe Tokenizer, ->
  describe "initialization", ->
    it "should require source to be passed", ->
      (expect -> new Tokenizer('something')).not.toThrow()
      (expect -> new Tokenizer()).toThrow('No source passed')
  
  describe "#getNextToken", ->
    beforeEach ->
      @token = (str) ->
        new Tokenizer(str).getNextToken()

    describe "selector tokens", ->
      it "should extract a token object", ->
        (expect @token("#foo {}")).toEqual { type: 'selector', content: '#foo' }

      it "should ignore whitespace around token", ->
        (expect @token("#bar{}")).toEqual { type: 'selector', content: '#bar' }
        (expect @token("  #bar qwe .asdf{}")).toEqual { type: 'selector', content: '#bar qwe .asdf' }
        (expect @token(" span a[href^='https://']{}")).toEqual { type: 'selector', content: "span a[href^='https://']" }
        (expect @token("span\n{}")).toEqual { type: 'selector', content: 'span' }

      it "should allow splitting by comma", ->
        (expect @token("#foobar, #qwe {}")).toEqual { type: 'selector', content: '#foobar' }
        (expect @token(", #qwe {}")).toEqual { type: 'selector', content: '#qwe' }

    describe "block start tokens", ->
      it "should extract a token object", ->
        (expect @token("{")).toEqual { type: 'blockStart', content: '{' }
        (expect @token("{ .foo-bar; } #whee {")).toEqual { type: 'blockStart', content: '{' }

    describe "style tokens", ->
      it "should extract a token object", ->
        (expect @token(".a-style;")).toEqual { type: 'style', content: '.a-style' }

    describe "block end tokens", ->
      it "should extract a token object", ->
        (expect @token("}")).toEqual { type: 'blockEnd', content: '}' }

    describe "unidentified tokens", ->
      it "should throw an error", ->
        (expect => @token("**;12")).toThrow("Unexpected token near **;12")

    it "should slice token from text", ->
      tokenizer = new Tokenizer("#foo bar {}")
      (expect tokenizer.getNextToken()).toEqual { type: 'selector', content: '#foo bar' }
      (expect tokenizer.getNextToken()).toEqual { type: 'blockStart', content: '{' }
      (expect tokenizer.getNextToken()).toEqual { type: 'blockEnd', content: '}' }

    it "should parse more or less real construct correctly", ->
      tokenizer = new Tokenizer("
        #main-container {
          .rounded-box;
          .thick-border;
        }

        #hero-unit h2 {
          .underline-border; 
          .gray-background;
        }
      ")
      (expect tokenizer.tokenize()).toEqual [
        { type: 'selector', content: '#main-container' },
        { type: 'blockStart', content: '{' },
        { type: 'style', content: '.rounded-box' },
        { type: 'style', content: '.thick-border' },
        { type: 'blockEnd', content: '}' },
        { type: 'selector', content: '#hero-unit h2' },
        { type: 'blockStart', content: '{' },
        { type: 'style', content: '.underline-border' },
        { type: 'style', content: '.gray-background' },
        { type: 'blockEnd', content: '}' },
      ]
