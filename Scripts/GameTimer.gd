extends Timer

@export var TIME_LOSS = 3 


func lose_time():
	# Decrease timer by x seconds
	if time_left < TIME_LOSS:
		emit_signal("timeout")
		stop()
	else:
		start(time_left - TIME_LOSS)

func _on_timeout():
	get_tree().reload_current_scene()

func _ready():
	timeout.connect(_on_timeout)
