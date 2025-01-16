extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("add_points"):
		body.add_points(1)  # Dodaj 1 punkt graczowi
		print("+1 coin")
		queue_free()  # Usuń diament po zebraniu
