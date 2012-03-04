(function() {
  var CleanMyHtml, Tokenizer, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  CleanMyHtml = (function() {

    function CleanMyHtml() {}

    CleanMyHtml.prototype.tokenize = function(text) {};

    CleanMyHtml.prototype.test = function() {
      return 1;
    };

    return CleanMyHtml;

  })();

  Tokenizer = (function() {

    function Tokenizer(text) {
      this.getNextToken = __bind(this.getNextToken, this);      this.text = text || (function() {
        throw 'No source passed';
      })();
      this.text = this.text.replace(/\n/gm, ' ');
    }

    Tokenizer.prototype.getNextToken = function() {
      var blockEndRegexp, blockStartRegexp, content, index, match, selectorRegexp, styleRegexp, type, _ref;
      this.text = this.text.replace(/\s*/m, '');
      if (this.text.length === 0) return null;
      console.log("Text after stripping whitespace: \"" + this.text + "\"");
      selectorRegexp = /^,?\s*([\w#.].+?)(?=\s*[,{])/;
      blockStartRegexp = /^{/;
      styleRegexp = /^\.[\w-]+(?=;)/;
      blockEndRegexp = /^}/;
      _ref = (function() {
        if (match = this.text.match(selectorRegexp)) {
          return [match[1], this.text.search(selectorRegexp), 'selector'];
        } else if (match = this.text.match(blockStartRegexp)) {
          return [match[0], this.text.search(blockStartRegexp), 'blockStart'];
        } else if (match = this.text.match(styleRegexp)) {
          return [match[0], this.text.search(styleRegexp), 'style'];
        } else if (match = this.text.match(blockEndRegexp)) {
          return [match[0], this.text.search(blockEndRegexp), 'blockEnd'];
        } else {
          throw "Unexpected token near " + this.text.slice(0, 21);
        }
      }).call(this), content = _ref[0], index = _ref[1], type = _ref[2];
      this.text = this.text.slice(content.length + index);
      if (type === 'style') this.text = this.text.slice(1);
      console.log("Type: " + type + "\n", "Content: " + content + "\n", "Remaining text: \"" + this.text + "\"\n");
      return {
        type: type,
        content: content
      };
    };

    Tokenizer.prototype.tokenize = function() {
      var token, tokens;
      tokens = [];
      while (token = this.getNextToken()) {
        tokens.push(token);
      }
      return tokens;
    };

    return Tokenizer;

  })();

  root.Tokenizer = Tokenizer;

  root.CleanMyHtml = new CleanMyHtml;

}).call(this);
