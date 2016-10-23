
extends Button

export var level = ''

func on_level_pressed():
	get_tree().change_scene('res://Assets/Scenes/' + level + '.tscn')