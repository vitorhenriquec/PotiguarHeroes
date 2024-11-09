class_name MainMenu
extends Control

@onready var autaButton = $MarginContainer/HBoxContainer/VBoxContainer/Auta as Button
@onready var isabelButton = $MarginContainer/HBoxContainer/VBoxContainer/Isabel as Button
@onready var nisiaButton = $MarginContainer/HBoxContainer/VBoxContainer/Nisia as Button

@onready var autaLevel = preload("res://levels/worlauta.tscn") as PackedScene
@onready var isabelLevel = preload("res://levels/worldisabel.tscn") as PackedScene
@onready var nisiaLevel = preload("res://levels/worldnisia.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	autaButton.button_down.connect(on_auta_button_down)
	isabelButton.button_down.connect(on_isabel_button_down)
	nisiaButton.button_down.connect(on_nisia_button_down)
	

func on_auta_button_down() -> void:
	get_tree().change_scene_to_packed(autaLevel)
	pass
	
func on_isabel_button_down() -> void:
	get_tree().change_scene_to_packed(isabelLevel)
	pass
	
func on_nisia_button_down() -> void:
	get_tree().change_scene_to_packed(nisiaLevel)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
