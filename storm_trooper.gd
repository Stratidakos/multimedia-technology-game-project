extends CharacterBody2D

const SPEED = 50.0
var player
var chase = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Walk")
		player = get_node("../../Jedi/Jedi")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
		move_and_slide()
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		

func _on_player_detection_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Jedi":
		chase = true

func _on_player_detection_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Jedi":
		chase = false


func _on_hit_box_area_2d_body_entered(body: Node2D) -> void:
	#player = get_node("../../Jedi/Jedi")
	if body.name == "Jedi" && player.get_node("AnimatedSprite2D").animation == "Hit":
		death()
	elif body.name == "Jedi":
		death()
		body.health -= 1
		
func death()-> void:
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
