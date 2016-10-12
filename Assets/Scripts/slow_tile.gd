
extends 'tile.gd'

export var slow_speed = -20

func _on_Area_body_enter(body):
	if(body == player):
		player.alter_speed(slow_speed)
