extends Entity

export var unlock_ev = true
onready var fc = $Node2D2
onready var jumpcontroller = $Node2D
var on_p = false
var is_gonna_run = false
var run_time = 0.0
var last_walk_dir = 0
var snap : Vector2
var no_slam = false
var attacking = false
var no_movement =  false
var on_water = false
var ctiltmult = 1
var previous_stone_frame = 0
var aip = false
var on_wning = false
var died = false
onready var status = $StatusThing
onready var weapon :MeleeWeapon= $Node2D2/HampterSprite/Node2D




func _ready():
	#weapon = $"Node2D2/HampterSprite/Gun"
	weapon.playerstatus = status
#	status.unlocked_item(GlobalData.Items.RISINGSLASH)
#	status.unlocked_item(GlobalData.Items.WATERBREATHING)
#	status.unlocked_item(GlobalData.Items.PIPEBOMB)
#	status.unlocked_item(GlobalData.Items.STOMP)
#	status.unlocked_item(GlobalData.Items.BROKENASSSLASH)
	if not unlock_ev:return
	Signals.connect("boss_death_anim_state",self,"boss_died")
	for i in GlobalData.Items.values():
		status.unlocked_item(i,true)


func boss_died(started):
	aip = started
	$HurtComponent.damage_override = 1 if not started else 0

func compare(eventa:InputEvent,eventb):
	if eventa is InputEventKey and eventb is InputEventKey:
		return eventa.scancode == eventb.scancode
	if eventa is InputEventJoypadButton and eventb is InputEventJoypadButton:		
		return (eventa as InputEventJoypadButton).button_index == eventb.button_index
	
	if eventa is InputEventJoypadMotion and eventb is InputEventJoypadMotion:
		return (eventa as InputEventJoypadMotion).axis == eventb.axis and sign(eventa.axis_value) == sign(eventb.axis_value) 
			


func _input(event:InputEvent):
	var relevant_actions := [
		"up","down","left","right"
	]
#
	if (event is InputEventKey):
		if event.echo:return
	



	for i in range(relevant_actions.size()):
		var actionstr = relevant_actions[i]
		var alist = InputMap.get_action_list(actionstr)

		for a in (alist):
			if compare(event,a):
				var inputmask = int(Input.is_action_just_pressed(actionstr))<<i
				if inputmask != 0:
					weapon.deal_with_input(inputmask)

				
				
				
		
	

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




func get_speed_mult(lowoverride=.5): return (lowoverride if on_water else 1.0)


func _physics_process(delta):
	if aip or on_wning or died:return
	
	if $StateMachine.state == $StateMachine/Hurt:return
	if is_riding():return
	
	
	if is_gonna_run and !attacking and status.has_item(Globals.Items.SPEEDBOOSTER):
		run_time += delta

	var speed = 15
	
	var current_dir_x = sign($"%DirComp".current_dir.x)
	
	
	if run_time >= 1 :
		$Circlething.show()
		$AnimatedSprite2.show()
		$DashBreaker.enable()
		$DashBreaker.cast_to.x = 40 * current_dir_x
		$Circlething.rotation_degrees += 32
		speed *= 2.5 if is_on_floor() else 1.25
	else:
		$Circlething.hide()
		$AnimatedSprite2.hide()
		$DashBreaker.disable()

	
	weapon_handling()
	
	if last_walk_dir != current_dir_x or current_dir_x == 0 or is_on_wall():
		if is_on_wall() and run_time > 1:
			velocity += (Vector2(-last_walk_dir,-.25)*450)*get_speed_mult()
		run_time = 0
		
	last_walk_dir = current_dir_x

	
	if (
		(!attacking or !is_on_floor()) and 
		not no_movement
	):
	
		velocity.x += current_dir_x * (speed*get_speed_mult()) 
	
	else:
		current_dir_x = 0
		velocity.x = 0
		
		
	Engine.time_scale = 1	
	
	#$"%Armthing".aim($"%DirComp".current_dir,Vector2($"%Armthing".scale.x,0))
	if current_dir_x != 0:
		fc.scale.x = current_dir_x
		$AnimatedSprite2.scale.y = -current_dir_x * 2


	if Input.is_action_just_pressed("jump") and !attacking:
		var slam =(Input.is_action_pressed("down") and !is_on_floor() and !no_slam)
		
		if jumpcontroller.jump(get_speed_mult(.8)) and not slam:
			$AudioStreamPlayer.play()
		
		if  slam and status.has_item(Globals.Items.STOMP):
			$StateMachine.set_state($StateMachine/stomp)
		
		
	if Input.is_action_just_released("jump") and velocity.y < 0 :
		velocity.y = 0




	
	
	
func weapon_handling():	
	
	# bitmask input fuckery :3
	weapon.setup_ip_status(
		Input.is_action_pressed("up"),
		Input.is_action_pressed("down")
	)
	
	weapon.is_idle = $StateMachine.state == $StateMachine/idle or $StateMachine.state == $StateMachine/walk and $DirComp.current_dir.x == 0
	weapon.on_floor = is_on_floor()

	weapon.dir.x = fc.scale.x
	
	#weapon.stop_pogoin()
	if Input.is_action_pressed("attack"):
		weapon.try_shooting()
	else:
		weapon.stop_firing()
		
		
	#weapon.start_pogo()





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
	velocity = Vector2(fc.scale.x * 60,-275*get_speed_mult())#


func _on_AttackStateMachine_stop_ALL_movement():
	no_movement = true


func _on_SpinSlash_entered():
	no_slam = true
	$Node2D2/HampterSprite.frame = 3





func _on_stomp_entered():
	$AnimatedSprite/Area2D.monitoring = true
	$PhysicsStuff.gravity_enabled = false

func _on_stomp_exited():
	$PhysicsStuff.gravity_enabled = true
	$AnimatedSprite/Area2D.monitoring = false
	if !is_on_floor():return
	$AudioStreamPlayer2.play()
	Signals.emit_signal("screenshake",Vector2.DOWN,32)
	for i in [-1,1,0]:
		var stone = preload("res://bullets/rockandstone.tscn").instance()
		stone.damage = 5
		stone.global_position = global_position + (Vector2.UP *5)
		stone.velocity.y = -250
		stone.velocity.x = 75 * i
		stone.lifetime = 2
		
		previous_stone_frame += 1
		previous_stone_frame %= 2
		if i != 0:
			stone.customdata.frame = previous_stone_frame
		else:
			stone.velocity.y -= 40
		
		stone.add_to_group("plrproj")
		get_tree().current_scene.add_child(stone)

		pass




func _on_SpinSlash_jump():
	return
	velocity.y = -300




func _on_HurtComponent_hurted(dam,on_water):
	$StateMachine.set_state($StateMachine/Hurt)
	if !on_water:
		velocity.x = -170 * fc.scale.x
		velocity.y = -150
		velocity *=get_speed_mult()
	else:
		velocity = Vector2.ZERO
	Hitfreeze.set_realtimescale(.01)
	create_tween().tween_property(
		Engine,
		"time_scale",
		1,
		0.125
	)
	
	
	return
	if dam >= 20:
		velocity.x *= 4
		velocity.y *= 2


func _on_Hurt_entered():
	$PhysicsStuff.friction_enabled = false
	run_time = 0
	$Circlething.hide()
	$AnimatedSprite2.hide()
	$DashBreaker.disable()


func _on_Hurt_exited():	
	$PhysicsStuff.friction_enabled = true
	
	if $StatusThing.current_hp <= 0:
		died = true
		$Node2D2.hide()
		$CPUParticles2D.emitting = true
		yield(get_tree().create_timer(2.0,false),"timeout")
		get_tree().change_scene("res://ends/death.tscn")


func on_water(water):

	
	if !status.has_item(Globals.Items.WATERBREATHING) or water.hurts_regardless:
		$HurtComponent.hurt(1,Vector2.ZERO,0,true,4000,true)
		global_position = water.get_eject_pos()
		return
		
	on_water = true
	status.on_water = true
	$Node2D.on_water = true
	$PhysicsStuff.gravmult = .4
	$PhysicsStuff.term_vel = PhysicsStuff.MAX_TERM_VEL *.2
	if !on_water:
		velocity.y = min(velocity.y,PhysicsStuff.MAX_TERM_VEL *.2)


func out_of_water():
	status.on_water = false
	$Node2D.on_water = false
	$Node2D.reset_jumps()
	on_water = false
	$PhysicsStuff.gravmult = 1
	$PhysicsStuff.term_vel = PhysicsStuff.MAX_TERM_VEL

func _on_idle_landed():
	
	
	$"%AudioStreamPlayer3".play()
