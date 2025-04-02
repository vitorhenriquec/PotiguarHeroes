extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
var actual_score = 0
@onready var mainMenuLevel = preload("res://mainmenu/main_menu.tscn") as PackedScene

var score_messages = {
	0:  "Fuja das rosas espinhosas!",
	1:  "Aprendeu a ler e escrever sozinha,\n ainda criança",
	2:  "Sua obra é marcada por forte espiritualidade\n e influência religiosa",
	3:  "Viveu apenas 24 anos (1876–1901),\n vítima de tuberculose.",
	4:  "Publicou apenas Horto (1900),\n repleto de lirismo e melancolia",
	5:  "Seu irmão, o escritor Henrique de Souza,\n organizou sua obra póstuma.",
	6:  "Nascida no RN, retratou a natureza e\n a cultura do sertão em seus versos.",
	7:  "Carlos Drummond de Souza destacou sua sensibilidade poética.",
	8:  "Escreveu mesmo enfrentando\nlimitações físicas devido à saúde frágil.",
	9:  "Usava versos acessíveis,\n mas profundamente emotivos.",
	10:  "Considerada uma das vozes mais delicadas\n da poesia brasileira do século XIX"
}

var high_contrast_material: ShaderMaterial
var is_high_contrast = false

@onready var color_rect = $ColorRect

func _ready():
	
	PlayerState.set_score(0)
	PlayerState.set_initial_position($player.position)
	player.follow_camera(camera)
	
	high_contrast_material = ShaderMaterial.new()
	high_contrast_material.shader = preload("res://shaders/high_contrast_shader.gdshader")
	
	$hud/control/message_container/score_message.text = score_messages[0]
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	$hud/control/message_container/score_message.text = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$hud/control/container/score_container/score_counter.text = PlayerState.score_count()
	
	if PlayerState.get_score() != actual_score and $player != null:
		$hud/control/message_container/score_message.text = score_messages[PlayerState.get_score()]
		actual_score = PlayerState.get_score()
		await get_tree().create_timer(5).timeout
		$hud/control/message_container/score_message.text = ""
		
	if PlayerState.get_score() == 0:
		actual_score = 0


func _on_flag_body_entered(body):
	var can_proceed = PlayerState.get_score() == 10
	
	if body.name == "player" and can_proceed:
		get_tree().change_scene_to_packed(mainMenuLevel)
	elif body.name == "player" and not can_proceed:
		$hud/control/message_container/score_message.text = "Colete todos os items!"
		await get_tree().create_timer(3).timeout
		$hud/control/message_container/score_message.text = "" # Replace with function body

var actual_font_size = 12

func _on_decrease_font_size_pressed() -> void:
	actual_font_size-=2
	$hud/control/message_container/score_message.add_theme_font_size_override("font_size", actual_font_size)


func _on_increase_font_size_pressed() -> void:
	actual_font_size+=2
	$hud/control/message_container/score_message.add_theme_font_size_override("font_size", actual_font_size)
	

func _on_high_contrast_pressed() -> void:
	is_high_contrast = !is_high_contrast
	_apply_shader(get_tree().current_scene)
		

func _apply_shader(node):
	for child in node.get_children():
		if child is Button or child is Label or child.name in ["score_counter", "scoremessage"]:
			continue
		
		if child is CanvasItem:  
			if child.material == null:
				child.material = ShaderMaterial.new()
			child.material.shader = high_contrast_material.shader if is_high_contrast else null
		elif child is Node3D:  
			if child is MeshInstance3D and child.get_surface_override_material(0):
				child.set_surface_override_material(0, high_contrast_material if is_high_contrast else null)
		_apply_shader(child)  
