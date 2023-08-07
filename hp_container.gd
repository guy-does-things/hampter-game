extends GridContainer

var playerstatus : StatusThing

var t = 0
var frame = 0

func _ready():
	for text in get_children():
		text.texture = text.texture.duplicate()


func _physics_process(delta):
	if !is_instance_valid(playerstatus):
		hide()
		return
	show()
	
	var max_hp = playerstatus.MAX_HP

	
	for kid in get_child_count():
		get_children()[kid].visible = kid < playerstatus.current_hp
		if kid < playerstatus.current_hp-1:get_children()[kid].texture.region.position.x = 0
