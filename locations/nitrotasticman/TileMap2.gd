extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _physics_process(delta):
	if SavesManager.current_save.global_data.get("car_scenario"):
		queue_free()
