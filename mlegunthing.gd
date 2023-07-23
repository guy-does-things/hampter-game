class_name MeleeWeapon
extends GdtGun




enum Dirs{
	UP=1,
	DOWN=2,
	LEFT=4,
	RIGHT=8,
	
	# tells stuff to CHECK ACTIONS, not stuff
	IAUP=10,
	IADOWN=11
}

enum FloorRequirementModes{
	ALL=0,
	YES=1,
	NO=2
}

onready var attack_machine :StateMachine= $AttackStateMachine
var playerstatus : StatusThing setget set_playerstatus;func set_playerstatus(ps):playerstatus = ps
	
	
var input_buffer := []
var attack_list : Array
var time_since_pressed := 0.0
var on_floor = false
var is_idle


func _init():
	connect("fired",self,"on_fired")

class MotionInputFuckery:
	var requires_idle :int
	var requires_on_floor : int
	var inputs : Array
	var state_required :State
	var attack_state : State
	var forgiveness = 0
	var item_req
	
	# def value is 1
	func _init(floor_req:int,input_req:Array,state,attack,requiresidle,forgiveness,itemrequired):
		item_req = itemrequired
		requires_on_floor = floor_req
		inputs = input_req
		state_required = state
		attack_state = attack
		requires_idle =requires_idle
		self.forgiveness = forgiveness 
		
	

	func compare(input_list:Array):
		var inputidx = 0
		var total_forgiveness :int= inputs.size() + forgiveness
		var iters = 0
		if inputs.size() == 0: return true
		
		
		for input in inputs:
			if input == Dirs.IADOWN:
				if Input.is_action_pressed("down"):
					inputidx += 1 
			elif input == Dirs.IAUP:				
				if Input.is_action_pressed("up"):
					inputidx += 1 
					
		
		
		for input in input_list:
			
			
			if inputidx >= inputs.size():return true
			if iters > forgiveness:return false



			elif input == inputs[inputidx]:
				inputidx += 1
				
			iters += 1
		
		if inputidx >= inputs.size():return true
	
	
	
	func item_check(status:StatusThing):
		return status.has_item(item_req) or item_req == 0


	
	func match_floor_state(of:bool,fs=requires_on_floor):
		if fs == FloorRequirementModes.ALL:return true
		
		if fs == FloorRequirementModes.YES:return of
		
		return !of
		
	
		
		
		

func on_fired(gun):
	var attack = null
	
	for at in attack_list:
		var attack_thing :MotionInputFuckery = at
	
		if (!attack_machine.state == attack_thing.state_required or 
			!attack_thing.compare(input_buffer) or 
			!attack_thing.match_floor_state(on_floor) or 
			!attack_thing.match_floor_state(is_idle,attack_thing.requires_on_floor) or 
			!attack_thing.item_check(playerstatus)
		):
			continue
		
		attack = attack_thing.attack_state
	
	
	if attack != null:
		input_buffer = []
		attack_machine.set_state(attack)
		
	
	


func deal_with_input(i:int):
	#if time_since_pressed <= .02:
	#	if not (input_buffer.size() == 0 or i != input_buffer[-1] ):
	#		return
		
	time_since_pressed = 0
	input_buffer.append(i)
	




func _physics_process(delta):
#	print(time_since_pressed)
	if input_buffer.size() > 0:
		if time_since_pressed > .24:
			input_buffer.remove(0)
			time_since_pressed = 0
		time_since_pressed += delta
	else:
		time_since_pressed = 0
	
		
	
	
func fire_condition():
	return !$AnimationPlayer.is_playing() and .fire_condition()

func cooldown()->GDScriptFunctionState:
	

	if !$AnimationPlayer.is_playing():
		yield(get_tree(),"idle_frame")
	else:
		yield($AnimationPlayer,"animation_finished")
	
	
	return null





