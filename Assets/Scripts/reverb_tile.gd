
extends 'tile.gd'

export var reverb_strength = 0.25

func _on_Area_body_enter(body):
	if(body == player):
		player.reverb(reverb_strength, row)
