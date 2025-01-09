extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jedi":
		var player = get_node("../Jedi/Jedi")
		var endor = player.get_parent().get_parent()
		if endor.name == "Endor" and player.collectables == Game.lvl1collectables:
			var newTime = (Time.get_ticks_msec() - endor.levelTime) / 1000
			Utils.loadGame()
			print(Game.lvl1time)
			print(newTime)
			if Game.lvl1time == null:
				Game.lvl1time = newTime
				Utils.saveStats()
			elif Game.lvl1time > newTime:
				Game.lvl1time = newTime
				Utils.saveStats()
			get_tree().change_scene_to_file("res://Levels/levels.tscn")
		
		
