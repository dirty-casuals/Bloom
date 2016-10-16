
extends 'tile.gd'

export var slow_factor = 0.3

func _on_body_enter(body):
	if body == player:
		player.on_enter_tile(points_to_add, row, funcref(player, 'alter_speed'), slow_factor)
