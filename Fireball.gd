extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 200
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 100 * delta
