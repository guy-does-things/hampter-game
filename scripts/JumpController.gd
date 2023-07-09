extends Node2D


signal jumped(jump)

export var max_jumps = 0
export var jump_force = -200
onready var e : Entity = get_parent()
var __coyote_time := Timer.new()
onready var jumps = max_jumps
var jump_count = 0

var on_rope = false
var on_wall = false
var on_water = false



func get_timer()-> Timer:
	return __coyote_time

func _ready():
	__coyote_time.wait_time = .1
	__coyote_time.one_shot = true
	add_child(__coyote_time)

func start_coyote_time():
	__coyote_time.start()


func base_jump_cond():
	return e.is_on_floor() or !__coyote_time.is_stopped() or on_rope or on_wall or on_water

func can_jump():
	return base_jump_cond() or jumps > 0

func jump(mult=1)-> bool:
	
	var jc1 = base_jump_cond()
	#print_debug(on_water)
	
	if jc1 or jumps > 0:
		if !jc1:
			jump_count += 1
			jumps -= 1
		actually_jump(mult)
		return true
	return false

func actually_jump(mult):
	emit_signal("jumped",jump_count)
	e.velocity.y = jump_force*mult
	__coyote_time.stop()



func reset_jumps():
	jump_count = 0
	jumps = max_jumps
	


func _on_ItemFuckery_got_djump():
	max_jumps += 1


func _on_Rope_entered():
	on_rope = true




func _on_WallSlide_entered():
	on_wall = true


func _on_WallSlide_exited():
	on_wall = false
