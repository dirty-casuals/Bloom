
extends 'tile.gd'

func _on_Area_body_enter(body):
	if(body == player):
		player.apply_impulse(player.get_translation(), Vector3(0,20,0))