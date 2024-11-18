extends Area2D


func _on_body_entered(body):
	if body.name == "robot":
		Globals.end_level.call_deferred()
