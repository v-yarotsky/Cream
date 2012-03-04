(function() {
  var CleanMyHtml, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  CleanMyHtml = (function() {

    function CleanMyHtml() {}

    CleanMyHtml.prototype.test = function() {
      return 1;
    };

    return CleanMyHtml;

  })();

  root.CleanMyHtml = new CleanMyHtml;

}).call(this);
