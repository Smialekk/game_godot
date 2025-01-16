extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60  # Prędkość ruchu przeciwnika
const MAX_DISTANCE = 150  # Maksymalny dystans, po którym przeciwnik odbija się
const JUMP_FORCE = -250.0  # Siła podskoku
const GRAVITY = 500.0  # Siła grawitacji
const JUMP_INTERVAL = 2.0  # Co ile sekund przeciwnik wykonuje podskok

var direction = -1  # Kierunek poruszania: 1 -> w prawo, -1 -> w lewo
var start_position: Vector2  # Pozycja początkowa przeciwnika
var distance_traveled = 0.0  # Pokonany dystans
var velocity: Vector2 = Vector2.ZERO  # Wektor prędkości
var time_since_last_jump = 0.0  # Zmienna do odmierzania czasu od ostatniego podskoku

func _ready() -> void:
	start_position = position  # Zapisz pozycję początkową

func _process(delta: float) -> void:
	# Aktualizuj czas podskoku
	time_since_last_jump += delta

	# Jeśli czas od ostatniego podskoku przekroczył JUMP_INTERVAL, wykonaj podskok
	if time_since_last_jump >= JUMP_INTERVAL:
		if position.y >= start_position.y:  # Podskakuj tylko, jeśli przeciwnik jest "na ziemi"
			velocity.y = JUMP_FORCE  # Wykonaj podskok
			time_since_last_jump = 0.0  # Zresetuj czas

	# Dodaj grawitację, aby przeciwnik opadał
	velocity.y += GRAVITY * delta

	# Aktualizuj pozycję przeciwnika w osi X
	position.x += direction * SPEED * delta

	# Aktualizuj pozycję przeciwnika w osi Y
	position.y += velocity.y * delta

	# Jeśli przeciwnik spadnie poniżej pozycji startowej (ziemia)
	if position.y > start_position.y:
		position.y = start_position.y  # Zresetuj pozycję do poziomu ziemi
		velocity.y = 0.0  # Zresetuj prędkość w osi Y

	# Obsługa zmiany kierunku po przejściu dystansu
	distance_traveled = position.distance_to(start_position)
	if distance_traveled >= MAX_DISTANCE:
		direction *= -1  # Zmień kierunek
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h  # Obróć animację
		start_position.x = position.x  # Zaktualizuj tylko pozycję X
		distance_traveled = 0.0  # Zresetuj pokonany dystans
