extends Area2D

@onready var label = $Label  # Referencja do napisu

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.score >= 12:
			var current_scene = get_tree().current_scene.scene_file_path
			var next_level_number = current_scene.get_basename().to_int() + 1
			var next_level_path = "res://scenes/level_" + str(next_level_number) + ".tscn"
			print("Przechodzisz do następnego poziomu!")
			get_tree().change_scene_to_file(next_level_path)
		else:
			# Aktualizacja napisu, aby pokazać obecne punkty
			label.text = "Aby przejsc dalej, zbierz wszystkie diamenty"
