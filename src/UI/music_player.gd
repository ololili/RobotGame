extends AudioStreamPlayer

var end_song_timer: float = 3.0
var timer: float = 0

var is_playing_race: bool = false
var is_fading_to_setup: bool = false

var race_music: AudioStream
var setup_music: AudioStream


func _ready():
	race_music = ResourceLoader.load("res://Assets/Sounds/Music/mountain-trials.ogg")
	setup_music = ResourceLoader.load("res://Assets/Sounds/Music/running.ogg")
	stream = setup_music
	play()

func _process(delta):
	if not playing:
		play()
	
	if is_playing_race != Globals.is_timing:
		swap_music()

	if is_fading_to_setup:
		fade_to_setup(delta)


func swap_music():
	is_playing_race = Globals.is_timing
	if is_playing_race:
		stream = race_music
		play()
	else:
		is_fading_to_setup = true
	
	
func fade_to_setup(delta):
	timer += delta
	volume_db -= delta * 10
	if timer > end_song_timer:
		timer = 0
		stream = setup_music
		play()
		is_fading_to_setup = false
		volume_db = 0
