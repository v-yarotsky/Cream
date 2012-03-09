(function() {
  var Expression, Style, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Expression = require('./expression').Expression;

  Style = (function(_super) {

    __extends(Style, _super);

    function Style(content) {
      Style.__super__.constructor.call(this, content);
      this.pattern = /(.+?);/g;
    }

    Style.prototype.build = function() {
      return this.content;
    };

    return Style;

  })(Expression);

  root.Style = Style;

}).call(this);
