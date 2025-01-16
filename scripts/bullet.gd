extends Node2D

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 150  # Prędkość ruchu przeciwnika
const MAX_DISTANCE = 200  # Maksymalny dystans, po którym przeciwnik odbija się

var direction = 1  # Kierunek poruszania: 1 -> w prawo, -1 -> w lewo
var start_position: Vector2  # Pozycja początkowa przeciwnika
var distance_traveled = 0.0  # Pokonany dystans

func _ready() -> void:
	start_position = position  # Zapisz pozycję początkową

func _process(delta: float) -> void:
	# Aktualizuj pozycję przeciwnika
	position.x += direction * SPEED * delta
	distance_traveled = position.distance_to(start_position)

	# Jeśli przeciwnik przekroczył maksymalny dystans, zmień kierunek
	if distance_traveled >= MAX_DISTANCE:
		direction *= -1  # Zmień kierunek
		sprite_2d.flip_h = not sprite_2d.flip_h  # Obróć animację
		start_position = position  # Zaktualizuj pozycję początkową
		distance_traveled = 0.0  # Zresetuj pokonany dystans
