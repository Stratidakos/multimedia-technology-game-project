extends CharacterBody2D

@export var speed = 2.5
@onready var disappearTimer = $DisappearTimer
var direction := Vector2.ZERO
var player

func _ready() -> void:
	disappearTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	if direction != Vector2.ZERO:	
		var velocity = direction * speed
		global_position.x += velocity.x
	player = get_node("../../Jedi/Jedi")

func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_disappear_timer_timeout() -> void:
	queue_free()
