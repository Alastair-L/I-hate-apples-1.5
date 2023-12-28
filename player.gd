extends Area2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.UP
	position += velocity * speed * delta
