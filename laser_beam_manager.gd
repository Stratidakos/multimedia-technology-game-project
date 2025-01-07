extends Node2D


func handleShotFired(laserBeam, position: Vector2, direction: Vector2):
	add_child(laserBeam)
	laserBeam.global_position = position
	laserBeam.set_direction(direction)
