extends Timer

@export var TIME_LOSS = 5 

func lose_time():
	# Decrease timer by x seconds
	if time_left < TIME_LOSS:
		emit_signal("timeout")
		stop()
	else:
		start(time_left - TIME_LOSS)
