extends CharacterBody2D


@export var WADDLE_SPEED = 700.0

# Don't actually set these in the editor, it's just so they aren't shared accross instances
@export var target: Node2D = null
@export var navigation_agent: NavigationAgent2D = null

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	#$AnimatedSprite2D.play("Waddle")
	navigation_agent = $Navigation/NavigationAgent2D
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

func set_movement_target():
	if target:
		navigation_agent.debug_enabled = true
		navigation_agent.target_position = target.global_position

func _physics_process(delta):
	# Hack to fix weird bug
	if !target:
		return
	
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * WADDLE_SPEED
	move_and_slide()

func _on_awake_radius_body_entered(body):
	if body.name != "Player":
		return
	
	# No target = asleep
	if !target:
		$AnimatedSprite2D.play("Wake")
		# Note this could also fire when the Bite animation finishes.
		await $AnimatedSprite2D.animation_finished
		# Note that there's a "bug" here where the wake animation will restart if you
		# Go in and out of the radius
		target = body
		$AnimatedSprite2D.play("Waddle")

func _on_charge_radius_body_entered(body):
	if body.name != "Player":
		return
	
	# Looks silly to bite here
	if abs(body.position.x - position.x) < 300:
		return
	
	var frames_to_wait = 1.5
	var time_for_full_animation = 7 / 12
	var wait_time = frames_to_wait / 12
	if body.position.x > position.x:
		$AnimatedSprite2D.play("Bite Right")
		await get_tree().create_timer(wait_time).timeout
		velocity = Vector2(30 * WADDLE_SPEED, 0)
	else:	
		$AnimatedSprite2D.play("Bite Left")
		await get_tree().create_timer(wait_time).timeout
		velocity = Vector2(-30 * WADDLE_SPEED, 0)
	
	move_and_slide()
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("Waddle")
	

func _on_non_colliding_hitbox_body_entered(body):
	if body.name == "Player":
		body.emit_signal("hit")
