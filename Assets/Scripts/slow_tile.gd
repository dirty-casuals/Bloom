
extends 'tile.gd'

export var slow_factor = 0.3

func _on_Area_body_enter(body):
	if(body == player):
		player.alter_speed(slow_factor, row)
