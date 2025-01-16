extends CharacterBody2D

const SPEED = 80.0  # Prędkość ruchu w lewo
const GRAVITY = 500.0  # Siła grawitacji
const MAX_FALL_SPEED = 200.0  # Maksymalna prędkość spadania

@onready var ray_cast_down: RayCast2D = $RayCast2D

func _ready() -> void:
	ray_cast_down.enabled = true

func _physics_process(delta: float) -> void:
	# Ruch w lewo
	velocity.x = -SPEED

	# Jeśli RayCast2D nie wykrywa platformy, przeciwnik zaczyna spadać
	if not is_on_floor() and not ray_cast_down.is_colliding():
		velocity.y += GRAVITY * delta  # Dodaj grawitację
		velocity.y = clamp(velocity.y, -MAX_FALL_SPEED, MAX_FALL_SPEED)
	else:
		velocity.y = 0  # Reset prędkości pionowej po wykryciu platformy

	# Przesuń przeciwnika
	move_and_slide()
