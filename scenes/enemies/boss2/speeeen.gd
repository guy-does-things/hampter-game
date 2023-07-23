extends State

onready var speenguns = [$"%Speengun", $"%SpeengunL", $"%SpeengunB", $"%SpeengunT"]
const DIRS = [Vector2.RIGHT,Vector2.LEFT,Vector2.DOWN,Vector2.UP]
var rot = 0
var is_gonna_fire = false
var trot = 0
const ROTINC = .6

func _ready():
	for i in range(4):
		(speenguns[i] as GdtGun).connect("proj_created",self,"speengunfired",[DIRS[i]])
	
	
func speengunfired(bul:GdtBullet,dir:Vector2):
	bul.rotation = dir.rotated(rot).angle()


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	$"%EXparts".emitting = true
	$FIreDelay.start()

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$"%EXparts".emitting = false
	is_gonna_fire = false
	
	$"%Flippables".disabled = false
	

func _state_logic(dt):
	if not is_gonna_fire:return
	
	
	entity.rotation_degrees += ROTINC * Engine.time_scale
	trot += ROTINC * Engine.time_scale
	$"%Flippables".disabled = true
	$"%EXparts".rotation_degrees = -entity.rotation_degrees
	
	
	rot = fmod(entity.rotation,PI*2)
	
	for i in range(4):
		
		speenguns[i].deal_with_dir(DIRS[i].rotated(rot))
		(speenguns[i] as GdtGun).try_shooting()


func _get_transition(dt):
	if trot >= 360:
		entity.rotation_degrees = 0
		trot = 0
		is_gonna_fire = false
		
		return $"%RandomAttacks"

func _on_FIreDelay_timeout():
	is_gonna_fire = true


func _can_transition_to()-> bool:
	return  $"%StatusThing".current_hp <= $"%StatusThing".MAX_HP *.25
