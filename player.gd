extends Area2D

enum MOVE_DIRECTION { LEFT, RIGHT, UP, DOWN }

@export var speed = 400
@export var move_direction = MOVE_DIRECTION.UP
var screen_size # Size of the game window.

func _ready():
	$AnimatedSprite2D.play()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"ui_right"):
		move_direction = MOVE_DIRECTION.RIGHT
	if Input.is_action_pressed(&"ui_left"):
		move_direction = MOVE_DIRECTION.LEFT
	if Input.is_action_pressed(&"ui_down"):
		move_direction = MOVE_DIRECTION.DOWN
	if Input.is_action_pressed(&"ui_up"):
		move_direction = MOVE_DIRECTION.UP


	if move_direction == MOVE_DIRECTION.RIGHT:
		velocity.x = 1
	if move_direction == MOVE_DIRECTION.LEFT:
		velocity.x = -1
	if move_direction == MOVE_DIRECTION.DOWN:
		velocity.y = 1
	if move_direction == MOVE_DIRECTION.UP:
		velocity.y = -1

	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
	#else:
		#$AnimatedSprite2D.stop()

	position += velocity * delta
	
	# Should never happen because the levels should be surrounded in walls
	position = position.clamp(Vector2.ZERO, screen_size)
#
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = &"right"
		#$AnimatedSprite2D.flip_v = false
		#$Trail.rotation = 0
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = &"up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
		#$Trail.rotation = PI if velocity.y > 0 else 0
