(function() {
  var Block, Body, Expression, Selector, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Expression = require('./expression').Expression;

  Selector = require('./selector').Selector;

  Body = require('./body').Body;

  Block = (function(_super) {

    __extends(Block, _super);

    function Block(content) {
      Block.__super__.constructor.call(this, content);
      this.pattern = /(.+?){(.+)}/;
    }

    Block.prototype.build = function() {
      var body, result, selector;
      result = this.content.match(this.pattern);
      selector = new Selector(result[1]).build();
      body = new Body(result[2]).build();
      return this.buildHash(selector, body);
    };

    Block.prototype.buildHash = function(selector, body) {
      var result;
      result = {};
      result[selector] = body;
      return result;
    };

    return Block;

  })(Expression);

  root.Block = Block;

}).call(this);
