extends Area2D

var speed = 400
var direction = Vector2()
var mousePos = Vector2()

func _process(delta):
	direction = Vector2()
	if Input.is_action_pressed("w"):
		direction.y = -1
	if Input.is_action_pressed("a"):
		direction.x = -1
	if Input.is_action_pressed("s"):
		direction.y = 1
	if Input.is_action_pressed("d"):
		direction.x = 1
	
	var viewportDimensions = get_viewport_rect().size
	var spriteDimensions = $PlayerSprite.texture.get_size() * scale
	
	var lowerBound = Vector2()+spriteDimensions/2
	var upperBound = viewportDimensions-spriteDimensions/2
	
	var newPos
	
	if direction.x == 0 or direction.y == 0:
		newPos = position + direction * delta * speed
		
	else:
		newPos = position + direction * delta * speed / sqrt(2)
		
	position = newPos.clamp(lowerBound,upperBound)
	
	mousePos = get_viewport().get_mouse_position()
	var mouseOffset = mousePos - position
	var angle = mouseOffset.angle()
	angle += PI/2
	$PlayerSprite.rotation = angle


func _on_area_entered(area):
	print(area)
	emit_signal("fireballCollision",area)
	pass # Replace with function body.
