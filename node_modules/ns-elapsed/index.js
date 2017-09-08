module.exports = function Elapsed() {
	var startTime = process.hrtime()
	return {
		set: function set() {
			startTime = process.hrtime()
		},
		get: function get() {
			var diff = process.hrtime(startTime)
			return diff[0] + (diff[1] / 1e9)
		}
	}
}
