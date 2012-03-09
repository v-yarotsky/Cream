(function() {
  var Body, Expression, Style, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Expression = require('./expression').Expression;

  Style = require('./style').Style;

  Body = (function(_super) {

    __extends(Body, _super);

    function Body(content) {
      Body.__super__.constructor.call(this, content);
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

    return Body;

  })(Expression);

  root.Body = Body;

}).call(this);
