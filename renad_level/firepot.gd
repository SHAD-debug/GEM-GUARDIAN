extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

func _ready():
	body_entered.connect(_on_body_entered)
	sprite.play("off")

func _on_body_entered(body):
	if body.name == "MaskDude" and sprite.animation == "off":
		start_trap_sequence()
	
	if body.name == "MaskDude" and sprite.animation == "on":
		get_tree().reload_current_scene()

func start_trap_sequence():
	sprite.play("hit")
	await get_tree().create_timer(1.0).timeout
	
	sprite.play("on")
	await get_tree().create_timer(2.0).timeout
	
	sprite.play("off")

func _process(_delta):
	if sprite.animation == "on":
		for body in get_overlapping_bodies():
			if body.name == "MaskDude":
				get_tree().reload_current_scene()
