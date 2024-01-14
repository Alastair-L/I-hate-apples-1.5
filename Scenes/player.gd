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

var immune = false

func _ready():
	print("Ready!")
	$AnimatedSprite2D.play()

func handle_player_input():
	if Input.is_action_pressed(&"ui_right"):
		move_direction = MOVE_DIRECTION.RIGHT
		handle_move_animation()
	if Input.is_action_pressed(&"ui_left"):
		move_direction = MOVE_DIRECTION.LEFT
		handle_move_animation()
	if Input.is_action_pressed(&"ui_down"):
		move_direction = MOVE_DIRECTION.DOWN
		handle_move_animation()
	if Input.is_action_pressed(&"ui_up"):
		move_direction = MOVE_DIRECTION.UP
		handle_move_animation()


func handle_move_animation():
	match move_direction:
		MOVE_DIRECTION.RIGHT:
			$AnimatedSprite2D.play("walk backward")
		MOVE_DIRECTION.LEFT:
			$AnimatedSprite2D.play("walk backward")
		MOVE_DIRECTION.UP:
			$AnimatedSprite2D.play("walk backward")
		MOVE_DIRECTION.DOWN:
			$AnimatedSprite2D.play("walk forward")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_player_input()
		


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
			if !immune:
				emit_signal("hit")
		else:
			$AnimatedSprite2D.play("spin one")
			move_direction = OPPOSITES[move_direction]



func _on_hit():
	print("I'm hit!")
	immune = true
	$AnimatedSprite2D.play("spin one")
	await get_tree().create_timer(1).timeout
	immune = false
	# Play animation
	# Give immunity for a sec
