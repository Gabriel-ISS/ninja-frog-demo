extends CPUParticles2D

class_name DashParticles

var flip_h = false:
	set(value):
		scale.x = -1 if value else 1
		flip_h = value
	
