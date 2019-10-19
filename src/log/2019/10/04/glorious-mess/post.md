# What a Glorious Mess

<time data-slug="glorious-mess" datetime="2019-10-04T21:42:00+0200">4 Oct, 2019</time>

I have a Point to make, and since I've been very fond of CoffeeScript for years,
I'll be using that to make it:

```coffeescript
class Point
	constructor: (@x = 0, @y = 0) ->
		
	draw: () ->
		console.log "[#{@x}, #{@y}]"

```

In the good old days of CoffeeScript 1.x, this would compile to the following
perfectly readable JS to serve in just about any browser:

```javascript
var Point;

Point = (function() {
  function Point(x, y) {
    this.x = x != null ? x : 0;
    this.y = y != null ? y : 0;
  }

  Point.prototype.draw = function() {
    return console.log("[" + this.x + ", " + this.y + "]");
  };

  return Point;

})();
```

When I say "perfectly readable", I mean just that - if someone wanted to take a peek at the
source for something, the browser's "View Source" menu was brilliant and the above would make
sense to most developers familiar with JavaScript.

## New Shiny

Then CoffeeScript 2.x came along, and because ES6 in the meantime had adopted
quite a lot of the stuff we already knew from CoffeeScript, the compiled code
looked much more like the CoffeeScript we'd written:

```javascript
var Point;

Point = class Point {
	constructor(x = 0, y = 0) {
	  this.x = x;
	  this.y = y;
	}

	draw() {
	  return console.log(`[${this.x}, ${this.y}]`);
	}
};
```

But there's of course a catch here... the compiled code (ES6) no longer runs in
just about every browser, so we need to use another post-processor called Babel
to generate something that can be served to just about any browser...
only, it creates a horrible mess that no one would ever want to read when inspecting the source:

```javascript
"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

(function () {
  var Point;

  Point =
  /*#__PURE__*/
  function () {
    function Point() {
      var x = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;
      var y = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;

      _classCallCheck(this, Point);

      this.x = x;
      this.y = y;
    }

    _createClass(Point, [{
      key: "draw",
      value: function draw() {
        return console.log("[".concat(this.x, ", ").concat(this.y, "]"));
      }
    }]);

    return Point;
  }();
}).call(void 0);
```

How on earth is *anyone* going to learn from reading that? Let alone spark that
curious "Aah, I see - so *that's* how you do that..." that fuels so many hours of
poking around other people's source code, that got myself to where I am today?

