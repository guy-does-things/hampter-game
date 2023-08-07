extends TextureRect

onready var parent := get_parent()
enum TransparencyModes{
	OPAQUE,
	ANIMATING,
	TRANSPARENT
	
}
var current_mode = TransparencyModes.OPAQUE


func _physics_process(delta):
	if not parent:
		return
	
	if parent.get_overlapping_bodies().size() > 0:
		transparency_reveal(TransparencyModes.TRANSPARENT)
		return
		
	transparency_reveal(TransparencyModes.OPAQUE)
	


func transparency_reveal(endm:int):
	if current_mode == endm or current_mode == TransparencyModes.ANIMATING:return
	
	var endval = 0 if endm == TransparencyModes.TRANSPARENT else 1
	current_mode = TransparencyModes.ANIMATING
	
	yield(create_tween().tween_property(self,"modulate:a",endval,.15),"finished")
	current_mode = endm
	
	
	
	
	
	
	
