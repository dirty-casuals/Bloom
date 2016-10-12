
extends 'tile.gd'

export var fast_speed = 25

func _on_Area_body_enter(body):
	if(body == player):
		player.alter_speed(fast_speed, row)
