extends Area2D

var player_status = load("res://scripts/status.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	$anim.play("collect")


func _on_anim_animation_finished():
	queue_free()
	PlayerState.increment_score()
