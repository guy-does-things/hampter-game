extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GdtBullet_startup(bullet):
	frame = bullet.customdata.get("frame",2)
	if frame == 2:
		bullet.area.min_hit_priority += 1
		bullet.area.max_hit_priority += 1
