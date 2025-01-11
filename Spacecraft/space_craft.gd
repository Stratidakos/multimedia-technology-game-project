extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jedi":
		var player = get_node("../Jedi/Jedi")
		var level = player.get_parent().get_parent()
		if level.name == "Endor" and player.collectables == Game.lvl1collectables:
			registerTime(level, Game.lvl1time)
		elif level.name == "Coruscant" and player.collectables == Game.lvl2collectables:
			registerTime(level, Game.lvl2time)
	


func registerTime(level: Node2D, timeToBeat) -> void:
	var newTime = (Time.get_ticks_msec() - level.levelTime) / 1000.0
	Utils.loadGame()
	if timeToBeat == null:
		if level.name == "Endor":
			Game.lvl1time = newTime
		elif level.name == "Coruscant":
			Game.lvl2time = newTime
		Utils.saveStats()
	elif timeToBeat > newTime:
		if level.name == "Endor":
			Game.lvl1time = newTime
		elif level.name == "Coruscant":
			Game.lvl2time = newTime
		Utils.saveStats()
	get_tree().change_scene_to_file("res://Levels/levels.tscn")
