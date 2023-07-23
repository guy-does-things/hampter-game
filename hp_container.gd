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

	if playerstatus.current_hp <= get_child_count() and playerstatus.current_hp > 0:
		var cheart :TextureRect= get_child(playerstatus.current_hp-1)
		cheart.texture.region.position.x = 13 * frame
		
		
		if t > .30:#/max(1,max_hp-playerstatus.current_hp):
			frame += 1
			frame %= 3
			t = 0
		
		t += delta
	
	for kid in get_child_count():
		get_children()[kid].visible = kid < playerstatus.current_hp
		if kid < playerstatus.current_hp-1:get_children()[kid].texture.region.position.x = 0
