extends ParallaxBackground

func _process(delta):
	scroll_offset.x -= Global.SCROLL_SPEED * delta
