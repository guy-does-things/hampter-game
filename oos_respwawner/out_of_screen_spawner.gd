tool
extends EnemySpawner


var ins = false


func can_spawn():return not ins

func _physics_process(delta):
	
	if not Engine.editor_hint:
		if can_spawn():
			spawn_enemy(null,MapManager.current_room_in)
	
		
func _on_VisibilityNotifier2D_screen_entered():
	ins = true

func _on_VisibilityNotifier2D_screen_exited():
	ins = false


