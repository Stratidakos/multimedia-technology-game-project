extends Node

const SAVE_PATH = "res://SavedStats.bin"

func saveStats():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"Collectables": Game.collectables,
		"TimeToCompleteLvl1": Game.lvl1time,
		"TimeToCompleteLvl2": Game.lvl2time,
		"TimeToCompleteLvl3": Game.lvl3time
	}
	var serializedJSON = JSON.stringify(data)
	file.store_line(serializedJSON)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.collectables = current_line["Collectables"]
				Game.lvl1time = current_line["TimeToCompleteLvl1"]
				Game.lvl2time = current_line["TimeToCompleteLvl2"]
				Game.lvl3time = current_line["TimeToCompleteLvl3"]
