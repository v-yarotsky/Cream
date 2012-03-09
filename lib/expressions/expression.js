(function() {
  var Expression, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Expression = (function() {

    function Expression(content) {
      this.content = content;
    }

    Expression.prototype.build = function() {
      throw 'not override method!';
    };

    return Expression;

  })();

  root.Expression = Expression;

}).call(this);
