extends CharacterBody2D

@export var ROTATION_SPEED = -4

# Movement
@onready var _follow :PathFollow2D = get_parent()
@onready var myline: Path2D = get_parent().get_parent()

@onready var tween_values = [0, 1]
var _speed :float = 1200.0
var goal = 0


func _start_tween():
	# Go back and forth (goal = 0, then 1, then 0, ...)
	goal = abs(goal - 1)
	var tween :Tween = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", _start_tween)
	
	# Actual properties to change
	tween.tween_property(_follow, 'progress_ratio', goal, 2)
	var rotations = 4
	var magic = (2 * PI * goal - 2 * PI * (1 - goal))
	tween.parallel().tween_property(self, 'rotation', rotation + rotations * magic , 2)

func _ready():
	_start_tween()

func _physics_process(delta):
	pass
	#var length = myline.curve.get_baked_length()
	#if _follow.get_progress_ratio() >= 0.9:
		#print(_follow.get_progress(), direction, _speed * delta * direction)
		#direction = -1
	#_follow.set_progress(_follow.get_progress() + (_speed * delta * direction))
	#rotation += delta * ROTATION_SPEED
