extends Area2D

var animationExec = false;
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jedi" and !animationExec:
		animationExec = true
		var player = get_node("../../Jedi/Jedi")
		player.collectables += 1
		var tweenUp = get_tree().create_tween()
		var tweenOpac = get_tree().create_tween()
		
		tweenUp.tween_property(self, "position", position - Vector2(0,35), 0.35)
		tweenOpac.tween_property(self, "modulate:a", 0, 0.3)
		
		tweenUp.tween_callback(queue_free)
		animationExec = false
