extends Node2D

var levelTime;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.connect("shotFired", _shot_fired)
	levelTime = Time.get_ticks_msec()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _shot_fired(laserBeam, position: Vector2, direction: Vector2) -> void:
	add_child(laserBeam)
	laserBeam.global_position = position
	laserBeam.set_direction(direction)
