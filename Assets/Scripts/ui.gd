
extends Node2D

onready var game_over_label = get_node('GameOver')
onready var paused_label = get_node('Paused')
onready var restart_button = get_node('RestartButton')
onready var start_button = get_node('StartButton')
onready var continue_button = get_node('ContinueButton')
onready var pause_button = get_node('PauseButton')
onready var player = get_tree().get_current_scene().get_node('Ball/Player')
onready var timer = get_tree().get_current_scene().get_node('UI/Time')

var paused = false

signal game_over_signal
signal game_reset_signal
signal game_start_signal

func _ready():
	set_process_input(true)
	connect('game_over_signal', player, 'on_game_over')
	connect('game_over_signal', timer, 'on_game_over')
	connect('game_reset_signal', player, 'on_game_reset')
	connect('game_reset_signal', timer, 'on_game_reset')
	connect('game_start_signal', player, 'on_game_start')
	connect('game_start_signal', timer, 'on_game_start')
	start_button.show()
	start_button.grab_focus()

func _input(event):
	if event.type == InputEvent.KEY:
		if event.scancode == KEY_ESCAPE and start_button.is_hidden() and restart_button.is_hidden():
			pause()
			get_tree().set_input_as_handled()

#func _fixed_process(delta):
#	if Input.is_key_pressed(KEY_ESCAPE) and start_button.is_hidden() and restart_button.is_hidden():
		#pause()

func _on_World_body_enter(body):
	pause_button.hide()
	game_over_label.show()
	restart_button.show()
	restart_button.grab_focus() 
	emit_signal('game_over_signal')

func _on_RestartButton_pressed():
	pause_button.show()
	game_over_label.hide()
	restart_button.hide()
	emit_signal('game_reset_signal')
	unpause()

func _on_StartButton_pressed():
	pause_button.show()
	start_button.hide()
	emit_signal('game_start_signal')

func _on_ContinueButton_pressed():
	pause_button.show()
	unpause()

func unpause():
	paused_label.hide()
	restart_button.hide()
	continue_button.hide()
	get_tree().set_pause(false)

func pause():
	get_tree().set_pause(true)
	paused_label.show()
	restart_button.show()
	continue_button.show()
	continue_button.grab_focus()

func toggle_paused():
	if player.is_game_started():
		if get_tree().is_paused():
			pause_button.show()
			unpause()
		else:
			pause_button.hide()
			pause()
