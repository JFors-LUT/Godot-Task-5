extends Node3D

@export var platforms: Array[PackedScene] = [
	preload("res://Scenes/platform_short.tscn"),
	preload("res://Scenes/platform_medium.tscn"),
	preload("res://Scenes/platform_long.tscn")]

var start_scene = preload("res://Scenes/platform_start.tscn")

var spawn_interval = 1.2

# Called when the node enters the scene tree for the first time.
func _ready():
	# find player in scene
	var player = get_tree().root.find_child("Player", true, false)
	if player == null:
		printerr("Couldn't find player in scene")
		return
	global_position = Vector3(player.global_position.x, player.global_position.y -1 , player.global_position.z - 20)
	var start: StaticBody3D = start_scene.instantiate()
	add_child(start)
	start.global_position = Vector3(player.global_position.x, player.global_position.y-1, player.global_position.z)

	var timer := Timer.new()
	timer.one_shot = false
	timer.wait_time = spawn_interval
	timer.connect("timeout", _on_timer_timeout)
	timer.autostart = true
	add_child(timer)

func _on_timer_timeout():
	spawn_platform()

func spawn_platform():
	if len(platforms) == 0:
		printerr("%s platform list empty!" % name)
		return
	var plat: PackedScene = platforms.pick_random()
	var clone = plat.instantiate()
	add_child(clone)
	clone.global_position = Vector3(global_position.x + randi_range(-3, 3), global_position.y, global_position.z)
