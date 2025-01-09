extends Node

const SAVE_PATH = "res://SavedStats.bin"

func saveStats():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"BestTimeToCompleteLvl1": Game.lvl1time,
		"BestTimeToCompleteLvl2": Game.lvl2time,
		"BestTimeToCompleteLvl3": Game.lvl3time
	}
	var serializedJSON = JSON.stringify(data)
	file.store_line(serializedJSON)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.lvl1time = current_line["BestTimeToCompleteLvl1"]
				Game.lvl2time = current_line["BestTimeToCompleteLvl2"]
				Game.lvl3time = current_line["BestTimeToCompleteLvl3"]
