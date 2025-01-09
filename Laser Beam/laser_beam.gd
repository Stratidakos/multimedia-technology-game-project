extends CharacterBody2D

@export var speed = 2.5
@onready var disappearTimer = $DisappearTimer
var direction := Vector2.ZERO

func _ready() -> void:
	disappearTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta) -> void:
	if direction != Vector2.ZERO:	
		velocity = direction * speed
		global_position.x += velocity.x

func set_direction(newDirection):
	self.direction = newDirection
	rotation += newDirection.angle()


func _on_disappear_timer_timeout() -> void:
	queue_free()
