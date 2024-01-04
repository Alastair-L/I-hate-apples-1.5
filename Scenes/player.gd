extends CharacterBody2D

enum MOVE_DIRECTION { LEFT, RIGHT, UP, DOWN }

const OPPOSITES = {
	MOVE_DIRECTION.LEFT: MOVE_DIRECTION.RIGHT,
	MOVE_DIRECTION.RIGHT: MOVE_DIRECTION.LEFT,
	MOVE_DIRECTION.UP: MOVE_DIRECTION.DOWN,
	MOVE_DIRECTION.DOWN: MOVE_DIRECTION.UP,
}

signal hit

@export var speed = 150
@export var move_direction = MOVE_DIRECTION.UP

func _ready():
	print("Ready!")
	$AnimatedSprite2D.play()


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

func _physics_process(delta):
	velocity = Vector2.ZERO
	if move_direction == MOVE_DIRECTION.RIGHT:
		velocity.x = 1
	if move_direction == MOVE_DIRECTION.LEFT:
		velocity.x = -1
	if move_direction == MOVE_DIRECTION.DOWN:
		velocity.y = 1
	if move_direction == MOVE_DIRECTION.UP:
		velocity.y = -1

	var collision_info = move_and_collide(velocity * speed)
	if collision_info:
		print("I collided with ", collision_info.get_collider().name)
		if collision_info.get_collider().is_in_group("enemies"):
			emit_signal("hit")
		else:
			move_direction = OPPOSITES[move_direction]



func _on_hit():
	print("I'm hit!")
	# Play animation
	# Give immunity for a sec
