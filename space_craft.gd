extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jedi":
		#TODO: stop timer and save time to complete level
		get_tree().change_scene_to_file("res://levels.tscn")
