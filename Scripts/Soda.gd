extends CharacterBody2D

enum MOVE_DIRECTION { LEFT, RIGHT, UP, DOWN }

const SPEED = 70.0

const OPPOSITES = {
	MOVE_DIRECTION.LEFT: MOVE_DIRECTION.RIGHT,
	MOVE_DIRECTION.RIGHT: MOVE_DIRECTION.LEFT,
	MOVE_DIRECTION.UP: MOVE_DIRECTION.DOWN,
	MOVE_DIRECTION.DOWN: MOVE_DIRECTION.UP,
}

@export var move_direction = MOVE_DIRECTION.RIGHT

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	# Add the gravity.
	#var velocity = new Vector2D()
	velocity = Vector2.ZERO
	if move_direction == MOVE_DIRECTION.RIGHT:
		velocity.x = 1
	if move_direction == MOVE_DIRECTION.LEFT:
		velocity.x = -1
	if move_direction == MOVE_DIRECTION.DOWN:
		velocity.y = 1
	if move_direction == MOVE_DIRECTION.UP:
		velocity.y = -1

	var collision_info = move_and_collide(velocity * SPEED)
	if collision_info:
		move_direction = OPPOSITES[move_direction]
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
		
func on_pickup(): 
	print("Slurped")
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()
