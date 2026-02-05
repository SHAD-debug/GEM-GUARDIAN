extends Area2D

@export var rotation_speed := 360.0

func _ready():
	connect("body_entered", _on_body_entered)

func _process(delta):
	rotation_degrees += rotation_speed * delta

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("die"):
			body.die()
