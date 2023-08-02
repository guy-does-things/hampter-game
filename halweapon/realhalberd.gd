extends MeleeWeapon

var dmgmult = 1.0


func set_playerstatus(ps:StatusThing):
	.set_playerstatus(ps)
	ps.connect("item_unlocked",self,"has_unlocked_hitbox")
	if ps.has_item(Globals.Items.BLADEUP):
		unloked_halberd_upgrade()
	
	
		
func has_unlocked_hitbox(item):
	if item == Globals.Items.BLADEUP:unloked_halberd_upgrade()


# mispelled, don care
func unloked_halberd_upgrade():
	$SpriteSheet.material.set_shader_param(
		"has_funny_upgrade",
		1
	)
	dmgmult = 1.1
	
	# basically the bisexual flag in shader param
	# increases damage by 1.1 hmmmm
	for hitbox in $HitBoxes.get_children():
		hitbox.damage = ceil(hitbox.damage*dmgmult)



# Called when the node enters the scene tree for the first time.
func _ready():
	#floor_req:int,input_req:Array,state,attack
	



	# first hit
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[],$AttackStateMachine/Attack3,$AttackStateMachine/Attack1,FloorRequirementModes.ALL,1,0))
	
	# triple hit loop
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[],$AttackStateMachine/Attack2,$AttackStateMachine/Attack3,FloorRequirementModes.ALL,1,0))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[],$AttackStateMachine/Attack1,$AttackStateMachine/Attack2,FloorRequirementModes.ALL,1,0))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[],$AttackStateMachine/None,$AttackStateMachine/Attack1,FloorRequirementModes.ALL,1,0))

	# EX skills
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.NO,[Dirs.IAUP],$AttackStateMachine/None,$AttackStateMachine/SpinSlash,FloorRequirementModes.ALL,32,Globals.Items.BROKENASSSLASH))
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.NO,[Dirs.IAUP],$AttackStateMachine/Unsure,$AttackStateMachine/SpinSlash,FloorRequirementModes.ALL,32,Globals.Items.BROKENASSSLASH))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.IADOWN],$AttackStateMachine/Unsure,$AttackStateMachine/SonicSlash,FloorRequirementModes.YES,1,Globals.Items.SOULBLAST ))
	
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.IADOWN],$AttackStateMachine/None,$AttackStateMachine/SonicSlash,FloorRequirementModes.YES,1,Globals.Items.SOULBLAST ))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.IAUP],$AttackStateMachine/None,$AttackStateMachine/Uppercut,FloorRequirementModes.YES,1,Globals.Items.RISINGSLASH ))
	
	
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.DOWN,Dirs.LEFT],$AttackStateMachine/None,$AttackStateMachine/BTrhow ,FloorRequirementModes.ALL,4,Globals.Items.BREAST))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.YES,[Dirs.DOWN,Dirs.RIGHT],$AttackStateMachine/None,$AttackStateMachine/BTrhow ,FloorRequirementModes.ALL,4,Globals.Items.BREAST))
						#floor_req:int,input_req:Array,state,attack,requiresidle,forgiveness,itemrequired

	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[Dirs.DOWN,Dirs.RIGHT,Dirs.UP],$AttackStateMachine/None,$AttackStateMachine/PipeBomb ,FloorRequirementModes.ALL,4,Globals.Items.PIPEBOMB))
	attack_list.append(MotionInputFuckery.new(FloorRequirementModes.ALL,[Dirs.DOWN,Dirs.LEFT,Dirs.UP],$AttackStateMachine/None,$AttackStateMachine/PipeBomb ,FloorRequirementModes.ALL,4,Globals.Items.PIPEBOMB))
	for hitbox in $HitBoxes.get_children():
		hitbox.is_enemy = is_enemy


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
	sattack.damage = 7*dmgmult
	sattack.lifetime = 1
	sattack.dir = dir
	sattack.dir.y -= .05
	sattack.is_enemy = is_enemy
	sattack.add_to_group("plrproj")
	
	get_tree().current_scene.add_child(sattack)



func battack():
	var sattack = preload("res://bullets/breast/breast.tscn").instance()
	sattack.global_position = global_position + Vector2.DOWN *4
	sattack.scale.x = dir.x
	sattack.speed = 386
	sattack.damage = 5*dmgmult
	sattack.lifetime = 10
	sattack.dir = dir
	
	sattack.is_enemy = is_enemy
	sattack.add_to_group("plrproj")
	
	get_tree().current_scene.add_child(sattack)

func pipebombattack():
	var sattack = preload("res://bullets/pipebomb/pipebomb.tscn").instance()
	
	sattack.global_position = global_position + Vector2.DOWN *4
	
	sattack.scale.x = dir.x
	sattack.damage = 15*dmgmult
	sattack.lifetime = 10
	sattack.dir = dir
	sattack.speed = 200
	sattack.velocity = Vector2(0,-150)
	sattack.is_enemy = is_enemy
	sattack.add_to_group("plrproj")
	
	get_tree().current_scene.add_child(sattack)
	

