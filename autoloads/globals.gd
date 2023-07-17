# only reason it's a class name is so i can acess Items as an export
class_name GlobalData
extends Node


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
}


export(Array,Resource) var item_data = null

static func item_to_id(val:int)-> int:
	return Items.values().find(val)
