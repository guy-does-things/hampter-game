extends MeleeWeapon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#floor_req:int,input_req:Array,state,attack
	
	

	# the fall


	# first hit
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[],$AttackStateMachine/Attack3,$AttackStateMachine/Attack1,FloorRequirementModes.ALL))
	
	# triple hit loop
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[],$AttackStateMachine/Attack2,$AttackStateMachine/Attack3,FloorRequirementModes.ALL))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[],$AttackStateMachine/Attack1,$AttackStateMachine/Attack2,FloorRequirementModes.ALL))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[],$AttackStateMachine/None,$AttackStateMachine/Attack1,FloorRequirementModes.ALL))

	# EX skills
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.NO,[Dirs.UP],$AttackStateMachine/None,$AttackStateMachine/SpinSlash,FloorRequirementModes.ALL, [Dirs.LEFT,Dirs.RIGHT]))
	
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.DOWN],$AttackStateMachine/None,$AttackStateMachine/SonicSlash,FloorRequirementModes.YES, [Dirs.LEFT,Dirs.RIGHT]))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.UP],$AttackStateMachine/None,$AttackStateMachine/Uppercut,FloorRequirementModes.YES, [Dirs.LEFT,Dirs.RIGHT]))
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[Dirs.DOWN,Dirs.LEFT],$AttackStateMachine/None,State.new() ,FloorRequirementModes.YES))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[Dirs.DOWN,Dirs.RIGHT],$AttackStateMachine/None,State.new() ,FloorRequirementModes.YES))



func stop_pogoin():
	pass
		
		
		
func start_pogo():
	pass
		
		

#func fire_condition():
#	return !$AnimationPlayer.is_playing() and .fire_condition()
	
		
func _on_Node2D_postfired(gun):
	$DelayTimer.start()
	


func _on_Node2D_fired(gun):
	$DelayTimer.stop()


