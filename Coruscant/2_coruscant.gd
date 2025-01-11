extends Node2D

const coruscantMusic = preload("res://Assets/space-fleet-sci-fi-orchestral-music-166953.mp3")

@onready var levelClock = %levelClock

# Called when the node enters the scene tree for the first time.
var levelTime = 0.0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuBackgroundMusic.change_music(coruscantMusic)
	GlobalSignals.connect("shotFired", _shot_fired)
	#levelTime = Time.get_ticks_msec()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var currentTime = Time.get_ticks_msec() - levelTime
	levelClock.text = str($CountDownTimer.time_left).substr(0,5)


func _shot_fired(laserBeam, position: Vector2, direction: Vector2) -> void:
	add_child(laserBeam)
	laserBeam.global_position = position
	laserBeam.set_direction(direction)


func _on_count_down_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Levels/levels.tscn")
