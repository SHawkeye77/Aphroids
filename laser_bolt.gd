extends Node2D

@export var direction = Vector2.ZERO

func _process(delta):
	# Move the laser bolt
	position += delta * direction * Global.LASER_BOLT_SPEED
	
	# Removing the laser bolt if it goes off the screen
	if (global_position.x < 0 or global_position.x > get_viewport_rect().size.x or 
		global_position.y < 0 or global_position.y > get_viewport_rect().size.y):
		self.queue_free()


func _on_area_entered(area):
	area.hit()
	self.queue_free()
