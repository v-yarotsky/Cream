(function() {
  var Parser, Root, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Root = require('./expressions/root').Root;

  Parser = (function() {

    function Parser() {}

    Parser.prototype.run = function(code) {
      code = this.split(code);
      return new Root(code).build();
    };

    Parser.prototype.split = function(code) {
      return code.replace(/\s*/g, '');
    };

    return Parser;

  })();

  root.Parser = Parser;

}).call(this);
