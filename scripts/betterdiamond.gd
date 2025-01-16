extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("add_points"):
		body.add_points(5)  # Dodaj 5 punktów graczowi
		print("+5 coin")
		queue_free()  # Usuń diament po zebraniu
