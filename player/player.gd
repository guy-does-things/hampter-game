extends Entity


enum Locations{
	DOOR,
	RECEPTION,
	HOSPITAL_ROOM
}

signal news_recived

onready var fc = $Node2D2
onready var jumpcontroller = $Node2D
export var can_swim = false
var on_p = false
var is_gonna_run = false
var run_time = 0.0
var last_walk_dir = 0
var snap : Vector2
var no_slam = false
var attacking = false
var no_movement =  false
var ctiltmult = 1


onready var weapon :MeleeWeapon= $Node2D2/HampterSprite/Node2D

func move():
	velocity = move_and_slide(velocity,Vector2.UP)

func start_moving_in_tube():
	hide()
	$Circlething.hide()
	$AnimatedSprite2.hide()
	can_slide = false
	$StateMachine.set_state($StateMachine/tuberide)
	$PhysicsStuff.friction_enabled = false
	$PhysicsStuff.gravity_enabled = false
	velocity = Vector2.ZERO
	fc.get_node("AnimationPlayer").play("idle")
	
func end_moving_on_tube():
	show()

	can_slide = true
	$StateMachine.set_state($StateMachine/idle)
	$PhysicsStuff.friction_enabled = true
	$PhysicsStuff.gravity_enabled = true


func is_riding():
	return $StateMachine.state == $StateMachine/tuberide



func _physics_process(delta):
	
	
	if is_riding():return
	
	
	if is_gonna_run and !attacking:
		run_time += delta

	var speed = 15
	
	var current_dir_x = sign($"%DirComp".current_dir.x)
	if run_time >= 1 :
		$Circlething.show()
		$AnimatedSprite2.show()
		$DashBreaker.enable()
		$DashBreaker.cast_to.x = 40 * current_dir_x
		$Circlething.rotation_degrees += 32
		speed *= 3
	else:
		$Circlething.hide()
		$AnimatedSprite2.hide()
		$DashBreaker.disable()

	
	weapon_handling()
	
	if last_walk_dir != current_dir_x or current_dir_x == 0 or is_on_wall():
		if is_on_wall() and run_time > 1:
			velocity += Vector2(-last_walk_dir,-.25)*450
		run_time = 0
		
	last_walk_dir = current_dir_x


	if (!attacking or !is_on_floor()) and not no_movement:
		velocity.x += current_dir_x * speed
	else:
		current_dir_x = 0
		velocity.x = 0
		
		
	
	
	
	#$"%Armthing".aim($"%DirComp".current_dir,Vector2($"%Armthing".scale.x,0))
	if current_dir_x != 0:
		fc.scale.x = current_dir_x
		$AnimatedSprite2.scale.y = -current_dir_x * 2


	if Input.is_action_just_pressed("jump") and !attacking:
		jumpcontroller.jump()
		if Input.is_action_pressed("down") and !is_on_floor() and !no_slam:
			$StateMachine.set_state($StateMachine/stomp)
		
		
	if Input.is_action_just_released("jump") and velocity.y < 0 :
		velocity.y = 0





	
	
	
func weapon_handling():	
	
	# bitmask input fuckery :3
	weapon.is_idle = $StateMachine.state == $StateMachine/idle or $StateMachine.state == $StateMachine/walk and $DirComp.current_dir.x == 0
	weapon.on_floor = is_on_floor()
	weapon.deal_with_input(MeleeWeapon.Dirs.LEFT & (int(Input.is_action_pressed("left"))<<2))
	weapon.deal_with_input(MeleeWeapon.Dirs.RIGHT & (int(Input.is_action_pressed("right"))<<3))
	weapon.deal_with_input(MeleeWeapon.Dirs.UP & int(Input.is_action_pressed("up")))
	weapon.deal_with_input(MeleeWeapon.Dirs.DOWN & (int(Input.is_action_pressed("down"))<<1))
	weapon.dir.x = fc.scale.x
	
	weapon.stop_pogoin()
	if Input.is_action_pressed("attack"):
		weapon.try_shooting()
	else:
		weapon.stop_firing()
	weapon.start_pogo()





func _on_Stomp_entered():
	$PhysicsStuff.gravity_enabled = false


func _on_Stomp_exited():
	$PhysicsStuff.gravity_enabled = true


func _on_walk_entered():
	is_gonna_run = true


func _on_walk_exited():
	is_gonna_run = false
	




func _on_AttackStateMachine_restrict_movement():
	attacking = true
	

func attacked():
	$Node2D2/HampterSprite.is_attacking = true
	
func finished_atk():
	$Node2D2/HampterSprite.is_attacking = false
	no_slam = false

func _on_AttackStateMachine_resume_movement():
	attacking = false
	no_movement = false
	finished_atk()
	$StateMachine.set_state($StateMachine.state)
	




func _on_Node2D_fired(gun):
	attacked()
	


func _on_Uppercut_entered():
	velocity = Vector2(fc.scale.x * 60,-275)



func _on_AttackStateMachine_stop_ALL_movement():
	no_movement = true


func _on_SpinSlash_entered():
	no_slam = true
	$Node2D2/HampterSprite.frame = 3



