
extends Camera

const player_path = 'Ball/Player'
onready var player = get_parent().get_node(player_path)
var camera_offset

func _ready():
	set_process(true)
	var player_position = player.get_translation()
	var camera_position = get_translation()
	camera_offset = camera_position - player_position

func _process(delta):
	var player_position = player.get_translation()
	set_translation(player_position + camera_offset)