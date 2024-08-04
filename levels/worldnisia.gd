extends Node2D


@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
var actual_score = 0

var score_messages = {
	0:  "",
	1:  "Seu nome era Dionísia Gonçalves Pinto,\nmas adotou Nísia Floresta Brasileira Augusta\npara evitar represálias",
	2:  "Foi uma das primeiras vozes a defender\nos direitos das mulheres no Brasil",
	3:  "Fundou a primeira escola para meninas no Brasil",
	4:  "Fluente em várias línguas, incluindo português, francês, italiano e inglês",
	5:  "Escreveu diversas obras ao longo de sua vida,\nabordando temas como a educação,\na condição da mulher e questões sociais",
	6:  "Também foi uma ferrenha defensora dos direitos dos indígenas e dos escravos",
	7:  "Introduziu métodos pedagógicos inovadores para a época, promovendo uma educação que valorizava o desenvolvimento crítico e intelectual das meninas",
	8:  "Tem um município com seu pseudônimo",
	9:  "Na Europa, se relacionou com importantes intelectuais e movimentos sociais da época",
	10:  "Seus livros mais conhecidos são Conselhos à Minha Filha e Opúsculo Humanitário"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerState.set_score(0)
	PlayerState.set_initial_position($player.position)
	player.follow_camera(camera)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$hud/control/container/score_container/score_counter.text = PlayerState.score_count()
	
	if PlayerState.get_score() != actual_score and $player != null:
		$hud/control/message_container/score_message.text = score_messages[PlayerState.get_score()]
		actual_score = PlayerState.get_score()
		await get_tree().create_timer(3).timeout
		$hud/control/message_container/score_message.text = ""
		
	if PlayerState.get_score() == 0:
		actual_score = 0
