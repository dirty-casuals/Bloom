
extends StaticBody

export(int) var row
var points_to_add = 50
onready var player = get_tree().get_current_scene().get_node("Ball/Player")

func _on_body_enter( body ):
	if player == body:
		player.on_enter_tile(points_to_add, row)
