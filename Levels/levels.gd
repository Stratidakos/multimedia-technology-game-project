extends Node2D


func _ready() -> void:
	MenuBackgroundMusic.play_menu_music()
	
func _on_geonosis_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Endor/1_endor.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/main.tscn")


func _on_kashyyyk_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Coruscant/2_coruscant.tscn")
