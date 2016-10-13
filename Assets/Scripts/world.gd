
extends Area

onready var game_over_label = get_node('UI/GameOver')
onready var restart_button = get_node('UI/RestartButton')
onready var player = get_tree().get_current_scene().get_node('Ball/Player')
onready var timer = get_tree().get_current_scene().get_node('UI/Time')

signal game_over_signal
signal game_reset_signal

func _ready():
	connect('game_over_signal', player, 'on_game_over')
	connect('game_over_signal', timer, 'on_game_over')
	connect('game_reset_signal', player, 'on_game_reset')
	connect('game_reset_signal', timer, 'on_game_reset')

func _on_World_body_enter(body):
	game_over_label.show()
	restart_button.show()
	emit_signal('game_over_signal')

func _on_RestartButton_pressed():
	game_over_label.hide()
	restart_button.hide()
	emit_signal('game_reset_signal')
