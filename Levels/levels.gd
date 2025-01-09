extends Node2D



	
func _on_geonosis_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Endor/1_endor.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/main.tscn")
