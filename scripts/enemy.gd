extends Node2D

var health
var speed

@export var en_type: String = "none"

func _ready():
	match en_type:
		"walker":
			create_walker()
		"runner":
			create_runner()
		"tank":
			create_tank()

func _process(delta):
	position.x += speed * delta

func create_walker():
	health = 10
	speed = 2
	$Sprite2D.modulate = "#D72638"
	
func create_runner():
	health = 5
	speed = 5
	$Sprite2D.modulate = "#F46036"

func create_tank():
	health = 20
	speed = 1
	$Sprite2D.modulate = "#FFD23F"
