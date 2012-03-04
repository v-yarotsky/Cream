(function() {
  var fs, jsdom, window;

  fs = require('fs');

  jsdom = require("jsdom");

  window = jsdom.jsdom("<html><head></head><body></body></html>").createWindow();

  global.navigator = {
    userAgent: 'jasmine'
  };

  global.window = window;

  global.document = window.document;

  global.location = "http://monitoring";

}).call(this);
