
extends 'tile.gd'

export var fast_factor = 1.3

func _on_Area_body_enter(body):
	if(body == player):
		player.alter_speed(fast_factor, row)
