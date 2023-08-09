extends State


export var speed = 10
var center :Vector2
func _state_logic(delta):
	center = MapManager.current_room_in.roomrect.get_global_rect().get_center()

	entity.velocity.x += entity.global_position.direction_to(center).x * speed
	
	
	
	
func _get_transition(dt):
	if abs(entity.global_position.x - center.x) < 10:
		return $"%Jump"
		
#

