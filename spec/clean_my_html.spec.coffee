require './spec_helper'
CleanMyHtml = require('../lib/clean_my_html').CleanMyHtml

describe "test", ->
  it "should return 1", ->
    (expect CleanMyHtml.test(1)).toEqual(1)
