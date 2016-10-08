
extends Camera

# Makes the camera follow the player
var player
var player_position
var camera_offset

func _ready():
	set_process(true)
	player = get_parent().get_node("Ball/Player")
	player_position = player.get_translation()
	var camera_position = get_translation()
	camera_offset = camera_position - player_position

func _process(delta):
	player_position = player.get_translation()
	set_translation(player_position + camera_offset)