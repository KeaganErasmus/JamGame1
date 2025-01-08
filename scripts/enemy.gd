extends Node2D

var health: int
var speed: int
var damage: int
var hit_rate: int

var attack_time: float = 0

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
	health = 20
	speed = 20
	damage = 5
	$Sprite2D.modulate = "#D72638"
	
func create_runner():
	health = 5
	speed = 50
	damage = 5
	$Sprite2D.modulate = "#F46036"

func create_tank():
	health = 20
	speed = 10
	damage = 5
	$Sprite2D.modulate = "#FFD23F"

func do_damage(dt: float):
	attack_time += dt
	if attack_time > hit_rate:
		print("hit")
		attack_time = 0
	pass
