extends Area2D

var sound_player: AudioStreamPlayer
var is_charging: bool = false
var is_active: bool = false

func _ready():
	sound_player = $audio_stream_player

func _process(_delta):
	if is_charging and not sound_player.playing:
		sound_player.play()
	if is_active != Globals.is_timing:
		is_active = Globals.is_timing
		if is_active:
			$animation_player.play("active")
		else:
			$animation_player.play("inactive")

func _on_body_entered(body):
	if body.name == "robot":
		is_charging = true
		Globals.entered_charge_station()


func _on_body_exited(body):
	if body.name == "robot":
		is_charging = false
		Globals.left_charge_station()
