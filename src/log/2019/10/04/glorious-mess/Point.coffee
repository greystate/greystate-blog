class Point
	constructor: (@x = 0, @y = 0) ->

	draw: () ->
		console.log "[#{@x}, #{@y}]"
