extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuBackgroundMusic.play_menu_music()
	Utils.loadGame()
	if Game.lvl1time != null:
		$Label2.text = str(Game.lvl1time) + " seconds"
	if Game.lvl2time != null:
		$Label6.text = str(Game.lvl2time) + " seconds"
	if Game.lvl3time != null:
		$Label7.text = str(Game.lvl3time) + " seconds"


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/main.tscn")
