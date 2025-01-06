extends CharacterBody2D


var health = 2
var collectables = 0
var enemyAttackCooldonw = false
var SPEED = 150.0
const JUMP_VELOCITY = -400.0
var attackFlag = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if health <= 0:
		get_node("AnimatedSprite2D").play("Death")
		#await get_node("AnimatedSprite2D").animation_finished
		await get_tree().create_timer(0.550).timeout
		SPEED = 0
		get_tree().change_scene_to_file("res://main.tscn")
		
	if Input.is_action_just_pressed("attack") and !attackFlag:
		attackFlag = true
		get_node("AnimatedSprite2D").play("Hit")
		await get_tree().create_timer(0.250).timeout
		attackFlag = false
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		get_node("AnimatedSprite2D").play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
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
		if velocity.y == 0 and !attackFlag:
			get_node("AnimatedSprite2D").play("Idle")
	if velocity.y > 0:
		get_node("AnimatedSprite2D").play("Fall")
	move_and_slide()


func _on_hit_box_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "StormTrooper" and !enemyAttackCooldonw:
		enemyAttackCooldonw = true
		health -= 1
		print(health)
		$DamageCooldown.start()

func _on_damage_cooldown_timeout() -> void:
	enemyAttackCooldonw = false
