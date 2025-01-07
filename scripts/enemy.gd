extends Node2D

var health: int
var speed: int

@export var en_type: String = "none"

func _ready():
	add_to_group("enemiesGroup")
	match en_type:
		"walker":
			create_walker()
		"runner":
			create_runner()
		"tank":
			create_tank()


func _process(delta):
	position.x += speed * delta
	
	if health <= 0:
		remove_from_group("enemiesGroup")
		queue_free()

func create_walker():
	health = 20
	speed = 20
	$Sprite2D.modulate = "#D72638"
	
func create_runner():
	health = 5
	speed = 50
	$Sprite2D.modulate = "#F46036"

func create_tank():
	health = 20
	speed = 10
	$Sprite2D.modulate = "#FFD23F"
