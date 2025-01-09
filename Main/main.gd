extends Node2D

func _ready() -> void:
	MenuBackgroundMusic.play_menu_music()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/levels.tscn")


func _on_guide_pressed() -> void:
	get_tree().change_scene_to_file("res://Guide/guide.tscn")


func _on_score_pressed() -> void:
	get_tree().change_scene_to_file("res://Score/score.tscn")
