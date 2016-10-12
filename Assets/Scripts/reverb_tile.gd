
extends 'tile.gd'

export var reverb_speed = -75

func _on_Area_body_enter(body):
	if(body == player):
		player.alter_speed(reverb_speed, row)
