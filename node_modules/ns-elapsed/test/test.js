var test = require('tape')
var Elapsed = require('../index.js')
var elapsed1 = Elapsed()
var elapsed2 = Elapsed()

test(function (t) {
	t.plan(8)
	elapsed1.set()
	setTimeout(function() {
		elapsed2.set()

		var got1 = elapsed1.get()
		t.ok(got1 > 0.88, got1 + ' is larger than 0.88')
		t.ok(got1 < 1, got1 + ' is smaller than 1')
		
		var got2 = elapsed2.get()
		t.ok(got2 > 0, got2 + ' is larger than 0')
		t.ok(got2 < 0.1, got2 + ' is smaller than 0.1')

		setTimeout(function() {

			var got3 = elapsed1.get()
			t.ok(got3 > 1.28, got3 + ' is larger than 1.28')
			t.ok(got3 < 1.4, got3 + ' is smaller than 1.40')

			var got4 = elapsed2.get()
			t.ok(got4 > 0.38, got4 + ' is larger than 0.38')
			t.ok(got4 < 0.5, got4 + ' is smaller than 0.50')

			t.end()
		}, 400)
	}, 900)
})