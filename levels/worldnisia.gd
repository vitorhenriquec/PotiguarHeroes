extends Node2D


@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
var actual_score = 0
@onready var mainMenuLevel = preload("res://mainmenu/main_menu.tscn") as PackedScene

var score_messages = {
	0:  "Fuja das moscas!",
	1:  "Seu nome era Dionísia Gonçalves Pinto,\nmas adotou Nísia Floresta Brasileira Augusta\npara evitar represálias",
	2:  "Foi uma das primeiras vozes a defender\nos direitos das mulheres no Brasil",
	3:  "Fundou a primeira escola para meninas no Brasil",
	4:  "Fluente em várias línguas, incluindo português, francês, italiano e inglês",
	5:  "Escreveu diversas obras ao longo de sua vida,\nabordando temas como a educação,\na condição da mulher e questões sociais",
	6:  "Também foi uma ferrenha defensora dos direitos dos indígenas e dos escravos",
	7:  "Introduziu métodos pedagógicos inovadores para a época,\n promovendo uma educação que valorizava o desenvolvimento crítico e intelectual das meninas",
	8:  "Tem um município com seu pseudônimo",
	9:  "Na Europa, se relacionou com importantes intelectuais e movimentos sociais da época",
	10:  "Seus livros mais conhecidos são Conselhos à Minha Filha e Opúsculo Humanitário"
}

var high_contrast_material: ShaderMaterial
var is_high_contrast = false

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
	
	pass

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
		$hud/control/message_container/score_message.text = ""


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
