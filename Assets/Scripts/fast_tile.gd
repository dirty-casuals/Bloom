
extends 'tile.gd'

export var fast_factor = 1.3

func _on_body_enter(body):
	if body == player:
		player.on_enter_tile(points_to_add, row, funcref(player, 'alter_speed'), fast_factor)