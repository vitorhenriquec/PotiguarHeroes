extends Area2D

func _on_body_entered(body: Node2D):
	if body.name == "player":
		PlayerState.set_score(0)
		body.free()
	pass # Replace with function body.
