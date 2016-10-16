
extends 'tile.gd'

func _on_body_enter( body ):
	if body == player:
		player.on_enter_tile(points_to_add, row)
