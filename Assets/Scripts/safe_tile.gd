
extends 'tile.gd'

export var next_scene = ''
export var final_scene = false

func _on_body_enter( body ):
	if body == player:
		player.on_enter_tile(points_to_add, row)
		get_tree().change_scene('res://Assets/Scenes/Main_menu.tscn')