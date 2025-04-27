extends Label

class_name PointsCounter

var current = 0:
	set(value):
		current = value
		text = 'x ' + str(value)
	
