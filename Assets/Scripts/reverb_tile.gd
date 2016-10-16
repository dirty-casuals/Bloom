
extends 'tile.gd'

export var reverb_strength = 0.25

func _on_body_enter(body):
	if body == player:
		player.on_enter_tile(points_to_add, row, funcref(player, 'reverb'), reverb_strength)
