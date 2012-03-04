fs = require('fs')
jsdom = require("jsdom")

window = jsdom.jsdom("
  <html>
    <head>
    </head>
    <body>
      <div id='test'></div>
    </body>
  </html>
").createWindow()

global.navigator =
  userAgent: 'jasmine'
global.window = window
global.document = window.document
global.location = "http://monitoring"

require('../vendor/jquery-1.7.1.min')
if (window.$)
  global.$ = window.$
