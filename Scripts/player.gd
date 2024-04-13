extends CharacterBody2D

signal hit

@export var BASE_SPEED = 60

enum MOVE_DIRECTION { LEFT, RIGHT, UP, DOWN }

const OPPOSITES = {
	MOVE_DIRECTION.LEFT: MOVE_DIRECTION.RIGHT,
	MOVE_DIRECTION.RIGHT: MOVE_DIRECTION.LEFT,
	MOVE_DIRECTION.UP: MOVE_DIRECTION.DOWN,
	MOVE_DIRECTION.DOWN: MOVE_DIRECTION.UP,
}

var move_direction = MOVE_DIRECTION.UP
var intended_move_direction = MOVE_DIRECTION.UP

var wall_speed_boost = 0
var soft_drink_speed_boost = 0
var immune = false
var can_change_direction = true


func _ready():
	print("Ready!")
	$AnimatedSprite2D.play()

func handle_player_input():
	if Input.is_action_just_pressed(&"ui_right"):
		intended_move_direction = MOVE_DIRECTION.RIGHT
	if Input.is_action_just_pressed(&"ui_left"):
		intended_move_direction = MOVE_DIRECTION.LEFT
	if Input.is_action_just_pressed(&"ui_down"):
		intended_move_direction = MOVE_DIRECTION.DOWN
	if Input.is_action_just_pressed(&"ui_up"):
		intended_move_direction = MOVE_DIRECTION.UP

	# BTW Zander if you're reading this all of this duplication is bad
	# code style - I'm just doing it to get it working.
	#if !can_change_direction:
		#return

	if intended_move_direction != move_direction:
		move_direction = intended_move_direction
		wall_speed_boost = max(0, wall_speed_boost - 40)
		handle_move_animation()


func handle_move_animation():
	var current_frame = $AnimatedSprite2D.get_frame()
	var current_progress = $AnimatedSprite2D.get_frame_progress()
	if soft_drink_speed_boost > 0:
		match move_direction:
			MOVE_DIRECTION.RIGHT:
				$AnimatedSprite2D.play("run right")
			MOVE_DIRECTION.LEFT:
				$AnimatedSprite2D.play("run left")
			MOVE_DIRECTION.UP:
				$AnimatedSprite2D.play("run backward")
			MOVE_DIRECTION.DOWN:
				$AnimatedSprite2D.play("run forward")
	else:
		match move_direction:
			MOVE_DIRECTION.RIGHT:
				$AnimatedSprite2D.play("walk right")
			MOVE_DIRECTION.LEFT:
				$AnimatedSprite2D.play("walk left")
			MOVE_DIRECTION.UP:
				$AnimatedSprite2D.play("walk backward")
			MOVE_DIRECTION.DOWN:
				$AnimatedSprite2D.play("walk forward")
	$AnimatedSprite2D.set_frame_and_progress(current_frame, current_progress)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_player_input()
		


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

	var collision_info = move_and_collide(velocity * speed)
	if collision_info:
		handle_collision(collision_info)
			
			
func handle_collision(collision_info): 
	print("I collided with ", collision_info.get_collider().name)
	if collision_info.get_collider().is_in_group("enemies"):
		if !immune:
			emit_signal("hit")
	elif collision_info.get_collider().is_in_group("Power ups"):
		collision_info.get_collider().on_pickup()
		soft_drink_speed_boost += 50
		await get_tree().create_timer(5).timeout
		soft_drink_speed_boost -= 50
	elif collision_info.get_collider().is_in_group("burger"):
		collision_info.get_collider().on_pickup()
	else:
		# We've collided with a wall
		$AnimatedSprite2D.play("spin one")
		wall_speed_boost = 60
		intended_move_direction = OPPOSITES[move_direction]
		move_direction = intended_move_direction
		can_change_direction = false
		await get_tree().create_timer(0.2).timeout
		wall_speed_boost = 120			
		can_change_direction = true

func _on_hit():
	print("I'm hit!")
	immune = true
	wall_speed_boost = 0
	$AnimatedSprite2D.play("spin one")
	await get_tree().create_timer(1).timeout
	immune = false
