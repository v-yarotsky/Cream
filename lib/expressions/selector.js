(function() {
  var Expression, Selector, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Expression = require('./expression').Expression;

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

  root.Selector = Selector;

}).call(this);
