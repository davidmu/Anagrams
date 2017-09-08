ns-elapsed
==========

> Simple, high resolution stopwatch for nodeJS. Ideal for benchmark times.

[![Build Status](https://travis-ci.org/ArtskydJ/ns-elapsed.svg?branch=master)](https://travis-ci.org/ArtskydJ/ns-elapsed)

# examples

Asynchronous example

```js
var Elapsed() = require('ns-elapsed')
var e = new Elapsed()
e.set() // This is superfluous because 'set()' is automatically called when 'e' was constructed.
setTimeout(function() { // Asynchronous code here
	console.log( e.get() )
}, 1000)
```

Synchronous example:

```js
var elapsed = require('ns-elapsed')()
// Synchronous code here
console.log( e.get() )
```

# api

```js
var Elapsed = require('ns-elapsed')
```

## `var e = new Elapsed()`

#### `e.set()`

Does not return anything. Automatically called upon construction.

#### `var sec = e.get()`

Returns the number of seconds elapsed. E.g. `13.947172826`, which is almost 14 seconds.

# install

Install with [NPM](http://nodejs.org)

	npm install ns-elapsed

# license

[MIT](http://opensource.org/licenses/MIT)
