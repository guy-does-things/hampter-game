extends MeleeWeapon

enum EXSKILLS{
	SOULBLAST=1,
	RISINGSLASH=2,
	BROKENASSSLASH=4,
	PIPEBOMB=8,
	BREAST=16,
	BLADEUP=32
}
#"filo del alma"

func unloked_halberd_upgrade():
	pass

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
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.NO,[Dirs.IAUP],$AttackStateMachine/None,$AttackStateMachine/SpinSlash,FloorRequirementModes.ALL,32))
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.NO,[Dirs.IAUP],$AttackStateMachine/Unsure,$AttackStateMachine/SpinSlash,FloorRequirementModes.ALL,32))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.IADOWN],$AttackStateMachine/Unsure,$AttackStateMachine/SonicSlash,FloorRequirementModes.YES,1 ))
	
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.IADOWN],$AttackStateMachine/None,$AttackStateMachine/SonicSlash,FloorRequirementModes.YES,1 ))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.IAUP],$AttackStateMachine/None,$AttackStateMachine/Uppercut,FloorRequirementModes.YES,1 ))
	
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.DOWN,Dirs.LEFT],$AttackStateMachine/None,$AttackStateMachine/BTrhow ,FloorRequirementModes.YES,4))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.DOWN,Dirs.RIGHT],$AttackStateMachine/None,$AttackStateMachine/BTrhow ,FloorRequirementModes.YES,4))



func stop_pogoin():
	pass
		
		
		
func start_pogo():
	pass



	

		
func _on_Node2D_postfired(gun):
	$DelayTimer.start()
	


func _on_Node2D_fired(gun):
	$DelayTimer.stop()

func soul_attack():
	var sattack = preload("res://bullets/soul_attack.tscn").instance()
	sattack.global_position = global_position + Vector2.DOWN *4
	sattack.scale.x = dir.x
	sattack.speed = 386
	sattack.damage = 3
	sattack.lifetime = 1	
	sattack.dir = dir
	sattack.dir.y -= .05
	
	get_tree().current_scene.add_child(sattack)



func battack():
	var sattack = preload("res://bullets/breast/breast.tscn").instance()
	sattack.global_position = global_position + Vector2.DOWN *4
	sattack.scale.x = dir.x
	sattack.speed = 386
	sattack.damage = 3
	sattack.lifetime = 4
	sattack.dir = dir
	sattack.dir.y -= .05
	
	get_tree().current_scene.add_child(sattack)
