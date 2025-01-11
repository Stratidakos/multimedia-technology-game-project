extends CharacterBody2D


var health = 5
var collectables = 0
var enemyAttackCooldonw = false
var SPEED = 150.0
const JUMP_VELOCITY = -400.0
var attackFlag = false
var parryFlag = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var direction := Input.get_axis("ui_left", "ui_right")
	if not is_on_floor():
		velocity += get_gravity() * delta

	if health <= 0:
		get_node("AnimatedSprite2D").play("Death")
		#await get_node("AnimatedSprite2D").animation_finished
		await get_tree().create_timer(0.550).timeout
		SPEED = 0
		get_tree().change_scene_to_file("res://Main/main.tscn")
		
			
	if Input.is_action_just_pressed("attack") and !attackFlag:
		SPEED = 0
		velocity.x = 0
		attackFlag = true
		get_node("AnimatedSprite2D").play("Hit")
		await get_tree().create_timer(0.350).timeout
		SPEED = 150.0
		velocity.x = 0
		#velocity.x = direction * SPEED
		attackFlag = false
		
	
	if Input.is_action_just_pressed("parry") and !parryFlag:
		SPEED = 0
		velocity.x = 0
		parryFlag = true
		get_node("AnimatedSprite2D").play("Parry")
		await get_tree().create_timer(0.5).timeout
		SPEED = 150.0
		velocity.x = 0
		parryFlag = false
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		get_node("AnimatedSprite2D").play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if !attackFlag and !parryFlag:
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				get_node("AnimatedSprite2D").play("Walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				get_node("AnimatedSprite2D").play("Idle")
		if velocity.y > 0:
			get_node("AnimatedSprite2D").play("Fall")

	move_and_slide()


func _on_hit_box_area_2d_body_entered(body: Node2D) -> void:
	#print(body.name)
	if body.get_parent().name == "Enemies" and !enemyAttackCooldonw and get_node("AnimatedSprite2D").animation != "Hit":
		enemyAttackCooldonw = true
		health -= 1
		$DamageCooldown.start()
	elif body.name == "LaserBeam" and !enemyAttackCooldonw and get_node("AnimatedSprite2D").animation != "Parry":
		#body.queue_free()
		enemyAttackCooldonw = true
		health -= 1
		$DamageCooldown.start()

func _on_damage_cooldown_timeout() -> void:
	enemyAttackCooldonw = false


func _on_hit_box_area_2d_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.
