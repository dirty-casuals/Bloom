
extends Area

var game_over_label

func _ready():
	game_over_label = get_node('UI/GameOver')

func _on_World_body_enter(body):
	game_over_label.show()