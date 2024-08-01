extends Node2D

signal fireballCollision

var fireball = preload("res://Fireball.tscn")
var viewportDimensions
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	viewportDimensions = get_viewport_rect().size
	var player = $Player
	player.fireballCollision.connect(_on_fireball_collision)
	$Timer.start(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var fireballs = get_tree().get_nodes_in_group("fireballs")
	for fireball in fireballs:
		var outOfBoundsX = fireball.position.x > viewportDimensions.x+100 or fireball.position.x < -100
		var outOfBoundsY = fireball.position.y > viewportDimensions.y+100 or fireball.position.y < -100
		if outOfBoundsX or outOfBoundsY:
			print(fireball," Destroyed")
			fireball.queue_free()

func _on_fireball_collision(fireball):
	print(fireball," Destroyed")
	fireball.queue_free()
	
func _on_timer_timeout():
	print("Spawned Fireball")
	var newFireball = fireball.instantiate()
	add_child(newFireball)
	newFireball.add_to_group("fireballs")
	newFireball.direction.x = -1
	newFireball.position.y = 300
	newFireball.position.x = viewportDimensions.x
