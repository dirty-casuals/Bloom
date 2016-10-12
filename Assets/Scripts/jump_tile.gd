
extends 'tile.gd'

func _on_Area_body_enter(body):
	if(body == player):
		player.jump()