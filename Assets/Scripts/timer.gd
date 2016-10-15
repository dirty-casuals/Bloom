
extends Label

var time_start = 0
var time_now = 0
var game_ended = false
var game_started = false

func _ready():
	set_process(true)

func _process(delta):
	if not game_ended and game_started:
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		var str_elapsed = "%02d : %02d" % [minutes, seconds]
		set_text(str_elapsed)

func on_game_start():
	game_started = true
	time_start = OS.get_unix_time()

func on_game_over():
	game_ended = true

func on_game_reset():
	time_start = OS.get_unix_time()
	game_ended = false