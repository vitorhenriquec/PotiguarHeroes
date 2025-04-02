extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
var actual_score = 0
@onready var mainMenuLevel = preload("res://mainmenu/main_menu.tscn") as PackedScene

var score_messages = {
	0:  "",
	1:  "Fundou uma escola na Ribeira, em Natal",
	2:  "Foi educadora, historiadora e poetisa,\n destacando-se por seu papel \npioneiro na educação",
	3:  "Isabel começou a ensinar aos 27 anos",
	4:  "Defendeu fervorosamente \no ensino público para mulheres",
	5:  "Promoveu uma revolução no \nmagistério em Natal,\nelevando o status da \nprofissão docente.",
	6:  "Também se expressou \natravés da poesia,\n deixando um legado literário",
	7:  "Documentou e valorizou \na cultura local e\nas memórias de sua época",
	8:  "Ensinava com atividades \nlúdicas e estímulava\na criatividade",
	9:  "Lutou para que as \nmulheres tivessem as\nmesmas oportunidades\n educacionais que os homens",
	10:  "Se envolvia ativamente\nna gestão escolar,\ngarantindo que sua\n escola fosse um\n ambiente acolhedor e produtivo"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerState.set_score(0)
	PlayerState.set_initial_position($player.position)
	player.follow_camera(camera)
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


func _on_decrease_font_size_pressed() -> void:
	$hud/control/message_container/score_message.add_theme_font_size_override("font_size", 10)


func _on_increase_font_size_pressed() -> void:
	$hud/control/message_container/score_message.add_theme_font_size_override("font_size", 14)
