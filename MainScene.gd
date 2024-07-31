extends Node2D

signal fireballCollision

var fireball = preload("res://Fireball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready!!")
	var newFireball = fireball.instantiate()
	add_child(newFireball)
	newFireball.add_to_group("fireballs")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_tree().get_nodes_in_group("fireballs"))
	var fireballs = get_tree().get_nodes_in_group("fireballs")
	#for fireball in fireballs:
		#if fireball
		#print(fireball)
	pass

