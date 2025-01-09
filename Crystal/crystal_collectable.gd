extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Jedi":
		print("Jedi entered")
		var player = get_node("../../Jedi/Jedi")
		print(player.collectables)
		player.collectables += 1
		var tweenUp = get_tree().create_tween()
		var tweenOpac = get_tree().create_tween()
		
		tweenUp.tween_property(self, "position", position - Vector2(0,35), 0.35)
		tweenOpac.tween_property(self, "modulate:a", 0, 0.3)
		
		tweenUp.tween_callback(queue_free)
