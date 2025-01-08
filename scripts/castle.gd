extends StaticBody2D

@export var health = 100

func take_damage(amount: int):
	health -= amount
	print("ooft")
	

func _process(_delta):
	if health <= 0:
		print("ve lost")
