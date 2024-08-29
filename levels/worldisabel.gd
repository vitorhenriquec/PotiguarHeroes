extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
var actual_score = 0

var score_messages = {
	0:  "",
	1:  "Fundou uma escola na Ribeira, em Natal",
	2:  "Foi educadora, historiadora e poetisa, destacando-se\n por seu papel pioneiro na educação",
	3:  "Isabel começou a ensinar aos 27 anos",
	4:  "Defendeu fervorosamente o ensino público para mulheres",
	5:  "Promoveu uma revolução no magistério em Natal,\nelevando o status da profissão docente.",
	6:  "Também se expressou através da poesia,\n deixando um legado literário",
	7:  "Documentou e valorizou a cultura local e as memórias de sua época",
	8:  "Ensinava com atividades lúdicas e estímulava a criatividade",
	9:  "Lutou para que as mulheres tivessem as mesmas oportunidades educacionais que os homens",
	10:  "se envolvia ativamente na gestão escolar, garantindo que sua escola\n fosse um ambiente acolhedor e produtivo"
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
		$hud/control/message_container/score_message/scoremessage.text = score_messages[PlayerState.get_score()]
		actual_score = PlayerState.get_score()
		await get_tree().create_timer(3).timeout
		$hud/control/message_container/score_message.text = ""
		
	if PlayerState.get_score() == 0:
		actual_score = 0
