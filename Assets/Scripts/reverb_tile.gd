
extends 'tile.gd'

var player

func _ready():
	player = get_tree().get_current_scene().get_node("Ball/Player")

func _on_Area_body_enter(body):
	if(body == player):
		player.apply_impulse(player.get_translation(), Vector3(0,0,-50))
