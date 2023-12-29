extends CharacterBody2D

enum MOVE_DIRECTION { LEFT, RIGHT, UP, DOWN }

const OPPOSITES = {
	MOVE_DIRECTION.LEFT: MOVE_DIRECTION.RIGHT,
	MOVE_DIRECTION.RIGHT: MOVE_DIRECTION.LEFT,
	MOVE_DIRECTION.UP: MOVE_DIRECTION.DOWN,
	MOVE_DIRECTION.DOWN: MOVE_DIRECTION.UP,
}

signal hit

@export var speed = 1500
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


	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
	#else:
		#$AnimatedSprite2D.stop()

	#position += velocity * speed * delta
	
	# Should never happen because the levels should be surrounded in walls
	#position = position.clamp(Vector2.ZERO, screen_size)
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

	var collision_info = move_and_collide(velocity *speed * delta)
	if collision_info:
		print("I collided with ", collision_info.get_collider().name)
		move_direction = OPPOSITES[move_direction]

	#if collision_info:
		#velocity = velocity.bounce(collision_info.get_normal())

func _on_area_entered(area):
	print("hit!", area)
	emit_signal("hit")
	#if area is Wall:
		#print("wall!")


func _on_body_entered(body):
	# This is either a wall or a shelf
	if body is TileMap:
		print('hey!')
		print(body.get_layers_count())
		
		
