(function() {
  var Block, Expression, Root, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Expression = require('./expression').Expression;

  Block = require('./block').Block;

  Root = (function(_super) {

    __extends(Root, _super);

    function Root(content) {
      Root.__super__.constructor.call(this, content);
      this.pattern = /.+?{.+?}/g;
    }

    Root.prototype.build = function() {
      var block, blocks, result, _i, _len, _ref;
      _ref = [this.content.match(this.pattern), {}], blocks = _ref[0], result = _ref[1];
      if (blocks == null) return result;
      for (_i = 0, _len = blocks.length; _i < _len; _i++) {
        block = blocks[_i];
        this.buildBlock(result, block);
      }
      return result;
    };

    Root.prototype.buildBlock = function(result, block) {
      var element, selector, styles, _results;
      element = new Block(block).build();
      _results = [];
      for (selector in element) {
        styles = element[selector];
        _results.push(this.addElement(result, selector, styles));
      }
      return _results;
    };

    Root.prototype.addElement = function(result, selector, styles) {
      return result[selector] = result[selector] != null ? result[selector].concat(styles) : styles;
    };

    return Root;

  })(Expression);

  root.Root = Root;

}).call(this);
