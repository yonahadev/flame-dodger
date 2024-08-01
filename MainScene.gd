extends Node2D

signal fireballCollision
signal startGame

var fireball = preload("res://Fireball.tscn")
var player = preload("res://Player2.tscn")
var viewportDimensions
var rng = RandomNumberGenerator.new()
var label
var lives = 3
var startTime
var elapsedTime

var mainMenu

var inGame = false
# Called when the node enters the scene tree for the first time.
func _ready():
	viewportDimensions = get_viewport_rect().size
	mainMenu = $MainMenu
	$GUI.visible = false
	mainMenu.startGame.connect(_on_game_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inGame:
		var fireballs = get_tree().get_nodes_in_group("fireballs")
		for fireball in fireballs:
			var outOfBoundsX = fireball.position.x > viewportDimensions.x+100 or fireball.position.x < -100
			var outOfBoundsY = fireball.position.y > viewportDimensions.y+100 or fireball.position.y < -100
			if outOfBoundsX or outOfBoundsY:
				fireball.queue_free()
		elapsedTime = Time.get_unix_time_from_system()-startTime
		elapsedTime = snappedi(elapsedTime,1)
		$GUI/TimeContainer/Time.text = "Time: " + str(elapsedTime)

func _on_fireball_collision(fireball):
	print(fireball," Destroyed")
	fireball.queue_free()
	lives -= 1
	label.text = "Lives: " + str(lives)
	
func _on_game_start():
	inGame = true
	mainMenu.get_node("VBoxContainer").visible = false
	var newPlayer = player.instantiate()
	add_child(newPlayer)
	newPlayer.position = viewportDimensions/2
	newPlayer.fireballCollision.connect(_on_fireball_collision)
	$Timer.start(1)
	label = $GUI/LivesContainer/Lives
	label.text = "Lives: " + str(lives)
	startTime = Time.get_unix_time_from_system()
	$GUI.visible = true
	
	
func _on_timer_timeout():
	var newFireball = fireball.instantiate()
	add_child(newFireball)
	var random = rng.randi_range(1,4)
	match random:
		1:
			newFireball.direction.x = 1
			newFireball.position.x = 0
			newFireball.position.y = rng.randi_range(0,viewportDimensions.y)
		2:
			newFireball.direction.x = -1
			newFireball.position.x = viewportDimensions.x
			newFireball.position.y = rng.randi_range(0,viewportDimensions.y)
		3:
			newFireball.direction.y = 1
			newFireball.position.y = 0
			newFireball.position.x = rng.randi_range(0,viewportDimensions.x)
		4:
			newFireball.direction.y = -1
			newFireball.position.y = viewportDimensions.y
			newFireball.position.x = rng.randi_range(0,viewportDimensions.x)
	
	newFireball.speed = rng.randi_range(200,600)
	newFireball.add_to_group("fireballs")
	var delay = clamp(1-elapsedTime*0.02,0.15,1)
	print(delay)
	$Timer.start(delay)
