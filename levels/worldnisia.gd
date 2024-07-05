extends Node2D

var player_status = load("res://scripts/player_status.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	player_status.set_score(0)
	player_status.set_initial_position($player.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
