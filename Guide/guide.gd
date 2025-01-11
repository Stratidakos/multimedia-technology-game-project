extends Node2D

func _ready() -> void:
	MenuBackgroundMusic.play_menu_music()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/main.tscn")
