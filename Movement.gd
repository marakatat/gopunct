class_name Player
extends CharacterBody2D

# Exposed properties (editable in the Inspector like public fields in Unity)
@export var sprite: Sprite2D
@export var speed: float = 400.0
@export var jump_velocity: float = -500.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		# Flip the sprite based on movement direction
		if sprite:
			if direction > 0:
				sprite.flip_h = true
			elif direction < 0:
				sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
