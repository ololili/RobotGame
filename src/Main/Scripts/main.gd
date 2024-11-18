extends Node2D


var level_num: int = 0
var active_scene: PackedScene
var active_node: Node2D
var score_scene: PackedScene
var score_node: Node2D

func _ready():
	active_scene = load("res://src/World/Levels/level_0.tscn")
	# score_scene = load(the thing)
	active_node = active_scene.instantiate()
	add_child(active_node)

func to_score():
	score_node = score_scene.instantiate()
	active_node.queue_free()
	add_child(score_node)

func next_level():
	level_num += 1
	active_scene = load("res://src/World/Levels/level_" + str(level_num) + ".tscn")
	active_node = active_scene.instantiate()
	score_node.queue_free()
	add_child(active_node)

func to_final_score():
	pass