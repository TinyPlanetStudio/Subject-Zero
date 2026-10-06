extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Animation
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

var SPEED = 300
var JUMP_VELOCITY = -1000.0


func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump input.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get input direction and handle horizontal movement.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip sprite based on direction.
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Handle animations.
	if not is_on_floor():
		animated_sprite_2d.play("jump")
	elif velocity.x != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()
