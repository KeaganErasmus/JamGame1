extends Area2D

@export var health: int = 100

@onready var health_label: Label = $Health

func take_damage(amount: int):
	health -= amount
	health_label.text = str(health)

func _process(_delta):
	if health <= 0:
		print("ve lost")
