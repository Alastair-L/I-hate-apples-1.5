class_name BouncyMovement

extends RefCounted

var MOVE_DIRECTION = Constants.MOVE_DIRECTION

func _physics_process(delta):
	var speed = (BASE_SPEED + soft_drink_speed_boost + wall_speed_boost * 0)*1
	velocity = Vector2.ZERO
	if move_direction == MOVE_DIRECTION.RIGHT:
		velocity.x = 1
	if move_direction == MOVE_DIRECTION.LEFT:
		velocity.x = -1
	if move_direction == MOVE_DIRECTION.DOWN:
		velocity.y = 1
	if move_direction == MOVE_DIRECTION.UP:
		velocity.y = -1
