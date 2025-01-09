extends CharacterBody2D

@export var laserBeam: PackedScene
@onready var gunMarker = $Marker2D


const SPEED = 50.0
var player
var chase = false
var shoot = true

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	player = get_node("../../Jedi/Jedi")
	var direction = (player.position - self.position).normalized()
	if chase and !shoot:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Walk")
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
		move_and_slide()
	elif chase and shoot:
		shoot = false
		velocity.x = 0
		get_node("AnimatedSprite2D").play("Shoot")
		shootExecution()
		await get_tree().create_timer(0.250).timeout
		
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		

func _on_player_detection_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Jedi":
		chase = true
		$ShootTimer.start()

func _on_player_detection_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Jedi":
		chase = false


func _on_hit_box_area_2d_body_entered(body: Node2D) -> void:
	#if body.name == "Jedi" && player.get_node("AnimatedSprite2D").animation == "Hit":
	if body.name == "Jedi":
		death()
	#elif body.name == "Jedi":
	#	death()
	#	body.health -= 1
	#	player.get_node("DamageCooldown").start()


func _on_shoot_timer_timeout() -> void:
	shoot = true
	

func death() -> void:
	chase = false
	shoot = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()

func shootExecution() -> void:
	var laserInstance = laserBeam.instantiate()
	var directionToPlayer = (player.global_position - gunMarker.global_position).normalized()
	GlobalSignals.shotFired.emit(laserInstance, gunMarker.global_position, directionToPlayer)
