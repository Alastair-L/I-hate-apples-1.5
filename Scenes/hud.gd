extends Control

@export var timer_node: Timer = null
var timer_flashing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_node:
		var txt = str(ceil(timer_node.time_left))
		if timer_flashing:
			$TimerLabel.text = "[pulse freq=2 color=#ff000040 ease=-2.0][color=#ff8888ff][font_size=90][b]" + txt + "[/b][/font_size][/color][/pulse]"
		else:
			$TimerLabel.text = txt


func stop_flashing() -> void:
	timer_flashing = false

func flash_timer():
	# Flash timer. TODO: Animate size change
	print('heie')
	timer_flashing = true
	
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 3.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", stop_flashing)

