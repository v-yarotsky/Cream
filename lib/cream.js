(function() {
  var Block, Body, Expression, Parser, Root, Selector, Style, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Parser = (function() {

    function Parser() {}

    Parser.prototype.run = function(code) {
      code = this.skip_newlines(code);
      return new Root(code).build();
    };

    Parser.prototype.skip_newlines = function(code) {
      return code.replace(/\n*/g, '');
    };

    return Parser;

  })();

  root.Parser = Parser;

  Expression = (function() {

    function Expression(content) {
      this.content = content;
    }

    Expression.prototype.build = function() {
      throw 'not override method!';
    };

    return Expression;

  })();

  Block = (function(_super) {

    __extends(Block, _super);

    function Block(content) {
      Block.__super__.constructor.call(this, content);
      this.pattern = /\s*(.+?)\s*{(.+)}/;
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

  Body = (function(_super) {

    __extends(Body, _super);

    function Body(content) {
      Body.__super__.constructor.call(this, this.skip_whitespaces(content));
      this.pattern = /.+?;/g;
    }

    Body.prototype.build = function() {
      var result, style, styles, _i, _len, _ref;
      _ref = [this.content.match(this.pattern), []], styles = _ref[0], result = _ref[1];
      for (_i = 0, _len = styles.length; _i < _len; _i++) {
        style = styles[_i];
        this.buildStyle(result, style);
      }
      return result;
    };

    Body.prototype.buildStyle = function(result, style) {
      return result.push(new Style(style).build());
    };

    Body.prototype.skip_whitespaces = function(code) {
      return code.replace(/\s*/g, '');
    };

    return Body;

  })(Expression);

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

  Selector = (function(_super) {

    __extends(Selector, _super);

    function Selector(content) {
      Selector.__super__.constructor.call(this, content);
    }

    Selector.prototype.build = function() {
      return this.content;
    };

    return Selector;

  })(Expression);

  Style = (function(_super) {

    __extends(Style, _super);

    function Style(content) {
      Style.__super__.constructor.call(this, content);
      this.pattern = /(.+?);/;
    }

    Style.prototype.build = function() {
      return this.content.match(this.pattern)[1];
    };

    return Style;

  })(Expression);

  (function() {
    var addStyles, creamFile, links;
    creamFile = function(href) {
      return $.ajax({
        type: 'GET',
        url: href,
        success: function(data) {
          return $.cream(data);
        }
      });
    };
    links = $('link[rel="stylesheet/cream"]');
    links.each(function(k, v) {
      var href;
      href = $(v).attr('href');
      return creamFile(href);
    });
    addStyles = function(element, styles) {
      return $.each(styles, function(i) {
        var style;
        style = styles[i].match(/[^.].+/)[0];
        return element.addClass(style);
      });
    };
    $.fn.cream = function(code) {
      var parent, parser, _ref;
      _ref = [$(this), new Parser()], parent = _ref[0], parser = _ref[1];
      $.each(parser.run(code), function(selector, styles) {
        var element;
        element = parent.find(selector);
        element.live('create', function(event) {
          return addStyles($(this), styles);
        });
        return addStyles(element, styles);
      });
      return parent.trigger('cream');
    };
    return $.cream = function(code) {
      return $('body').cream(code);
    };
  })(jQuery);

}).call(this);
