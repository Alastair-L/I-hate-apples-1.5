extends CharacterBody2D


@export var WADDLE_SPEED = 700.0

var movement_target_position: Vector2 = Vector2(60.0,180.0)
var target = null


@export var navigation_agent: NavigationAgent2D = null

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	$AnimatedSprite2D.play("Waddle")
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.

func set_movement_target():
	if target:
		navigation_agent.target_position = target.global_position

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * WADDLE_SPEED
	move_and_slide()

func _on_detection_radius_body_entered(body):
	print(body)
	target = body


func _on_non_colliding_hitbox_body_entered(body):
	print(body, body.name)
	if body.name == "Player":
		body.emit_signal("hit")
		
