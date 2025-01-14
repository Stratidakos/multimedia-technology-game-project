extends Node2D

const endorMusic = preload("res://Assets/star-wars-style-march-165111.mp3")

@onready var levelClock = %levelClock

var levelTime = 0.0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuBackgroundMusic.change_music(endorMusic)
	GlobalSignals.connect("shotFired", _shot_fired)
	levelTime = Time.get_ticks_msec()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var currentTime = Time.get_ticks_msec() - levelTime
	levelClock.text = str(currentTime / 1000.0)

func _shot_fired(laserBeam, position: Vector2, direction: Vector2) -> void:
	add_child(laserBeam)
	laserBeam.global_position = position
	laserBeam.set_direction(direction)
