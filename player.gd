extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

var jump_count := 0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if jump_count == 1:
			if velocity.y < 0:
				anim.play("jump")
			else:
				anim.play("fall")
	else:
		jump_count = 0 

	# Jump
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

		if jump_count == 2:
			anim.play("doubleJump")

	# Movement
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * SPEED if direction else move_toward(velocity.x, 0, SPEED)

	# Flip
	if direction != 0:
		anim.flip_h = direction < 0

	# Animation
	if is_on_floor():
		if direction != 0:
			anim.play("walk")
		else:
			anim.play("idle")

	move_and_slide()

func die():
	get_tree().reload_current_scene()
