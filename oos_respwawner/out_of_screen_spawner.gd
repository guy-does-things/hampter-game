tool
extends EnemySpawner


var ins = false

func _physics_process(delta):
	
	if not Engine.editor_hint:
		if not ins:
			spawn_enemy(null,MapManager.current_room_in)
	
		print(not ins)


func _on_VisibilityNotifier2D_screen_entered():
	ins = true

func _on_VisibilityNotifier2D_screen_exited():
	ins = false
