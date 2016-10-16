
extends Label

var time_start = 0
var time_now = 0
var game_ended = false
var game_started = false
var time_elapsed = 0

func _ready():
	set_process(true)

func _process(delta):
	if not game_ended and game_started:
		time_elapsed = time_elapsed + delta
		var elapsed = int(time_elapsed)
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		var str_elapsed = "%02d : %02d" % [minutes, seconds]
		set_text(str_elapsed)

func on_game_start():
	time_start = OS.get_unix_time()
	game_started = true

func on_game_over():
	game_ended = true

func on_game_reset():
	time_elapsed = 0
	game_ended = false