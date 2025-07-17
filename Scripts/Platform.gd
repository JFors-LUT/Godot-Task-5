class_name Platform extends StaticBody3D

const DIR: Vector3 = Vector3.BACK
const SPEED: float = 0.1

var player = null

func _ready():
	player = get_tree().root.find_child("Player", true, false)

func _physics_process(_delta):
	# Move platform
	translate(DIR * SPEED)

	# Delete platform to avoid performance issues on long runs (remember that FORWARD is -Z)
	var limit = player.global_position.z + 20 if player != null else 20
	if (global_position.z > limit):
		queue_free()
