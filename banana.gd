extends Sprite2D

@export var SPEED = -2

func _physics_process(delta):
	rotation += delta * SPEED
