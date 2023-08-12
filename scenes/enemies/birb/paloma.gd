extends Node2D


var side = 0
var t  =0
func _ready():
	$"%TestScorpionE".velocity.x = 200 * side

func _physics_process(delta):
	t += delta
	$"%TestScorpionE".position.y = sin(t*5) * 32

func _on_TestScorpionE_tree_exited():
	queue_free()
	print(":3")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
