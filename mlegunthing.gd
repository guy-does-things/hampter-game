class_name MeleeWeapon
extends GdtGun




enum Dirs{
	UP=1,
	DOWN=2,
	LEFT=4,
	RIGHT=8
}

enum FloorRequirementModes{
	ALL=0,
	YES=1,
	NO=2
}

onready var attack_machine :StateMachine= $AttackStateMachine

var input_list := []
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
	var input_bitmask : int
	var state_required :State
	var attack_state : State
	var ignoredirs = []
	
	
	func _init(floor_req:int,input_req:Array,state,attack,requiresidle,keystoignore := []):
		requires_on_floor = floor_req
		inputs = input_req
		state_required = state
		attack_state = attack
		ignoredirs = keystoignore
		requires_idle =requires_idle
		
		for input in inputs:input_bitmask |= input
	

	func compare(input_list:Array):
		var testcmpmask = 0
		
		
		for input in input_list:
			if input in ignoredirs:continue
			testcmpmask |= input
		
					
				
		return (testcmpmask == input_bitmask) or input_bitmask == 0
	
	
	func match_floor_state(of:bool,fs=requires_on_floor):
		if fs == FloorRequirementModes.ALL:return true
		
		if fs == FloorRequirementModes.YES:return of
		
		return !of
		
	
		
		
		

func on_fired(gun):
	var attack = null
	
	for at in attack_list:
		var attack_thing :MotionInputFuckery = at
																# somehow forgot about the ENTIRE REASON I MADE THIS FUCKING SYSTEM
																
	
		if (!attack_machine.state == attack_thing.state_required or 
			!attack_thing.compare(input_list) or 
			!attack_thing.match_floor_state(on_floor) or 
			!attack_thing.match_floor_state(is_idle,attack_thing.requires_on_floor)
		):
			
			continue
		attack = attack_thing.attack_state
		#print(attack_thing.attack_state)
	
	
	if attack != null:
		attack_machine.set_state(attack)
		
	input_list = []
	
	


func deal_with_input(input:int):
	if input != 0:
		if input_list.size() > 0 and input_list[-1] != input:
			time_since_pressed = 0
			pass
		
		input_list.append(input)
		


func _physics_process(delta):
	if input_list.size() > 0:
		time_since_pressed += delta
	
	if time_since_pressed > .16:
		time_since_pressed = 0
		input_list.clear()
		
	
	
func fire_condition():
	return !$AnimationPlayer.is_playing() and .fire_condition()

func cooldown()->GDScriptFunctionState:
	

	if !$AnimationPlayer.is_playing():
		yield(get_tree(),"idle_frame")
	else:
		yield($AnimationPlayer,"animation_finished")
	
	
	return null





