# only reason it's a class name is so i can acess Items as an export
class_name GlobalData
extends Node

const BUTTON_LOOKUP={
	COMMON={
		JOY_L:"L",
		JOY_R:"R",
		JOY_L2:"L2",
		JOY_R2:"R2",
		JOY_L3:"L3",
		JOY_R3:"R3",
		JOY_DPAD_LEFT:"dpad left",
		JOY_DPAD_RIGHT:"dpad right",
		JOY_DPAD_UP:"dpad up",
		JOY_DPAD_DOWN:"dpad down",
		
		JOY_START:"start",
		JOY_SELECT:"select"
		
	},
	XBOX={
		JOY_XBOX_A:"A",
		JOY_XBOX_B:"B",
		JOY_XBOX_X:"X",
		JOY_XBOX_Y:"Y"
	},

	NINTENDO={
		JOY_DS_A:"A",
		JOY_DS_B:"B",
		JOY_DS_X:"X",
		JOY_DS_Y:"Y"
	},

	SONY={
		JOY_SONY_SQUARE:"[]",
		JOY_SONY_CIRCLE:"O",
		JOY_SONY_TRIANGLE:"△",
		JOY_SONY_X:"X"
	}
	
	
	
	
	
	
	
}

enum Items{
	# misc
	HPUP=1,
	# gating
	STOMP=2,
	WATERBREATHING=4,
	PLATFORM=8,
	SPEEDBOOSTER=16,

	# skills
	SOULBLAST=32,
	RISINGSLASH=64,
	BROKENASSSLASH=128,
	PIPEBOMB=256,
	BREAST=512,
	BLADEUP=1024
	HPUPONE=2048,
}


export(Array,Resource) var item_data = null
var is_endgame = false
var can_open_menu = true
var remapping = false


static func item_to_id(val:int)-> int:

	return Items.values().find(val)



func hit_fuckery(gp:Vector2)->AudioStreamPlayer:
	var hurtsfx = AudioStreamPlayer.new()
	hurtsfx.stream = preload("res://hitHurt(2).wav")
	hurtsfx.bus = "SFX"
	get_tree().current_scene.add_child(hurtsfx)
	hurtsfx.play()
	hurtsfx.connect("finished",hurtsfx,"queue_free")
	return hurtsfx
	
func died(gp:Vector2)->Node2D:
	var hit_fx = preload("res://hit_effect/hit_effect.tscn").instance()
	hit_fx.global_position = gp
	get_tree().current_scene.add_child(hit_fx)
	
	return hit_fx

