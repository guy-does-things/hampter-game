class_name StatusThing
extends Node


signal item_unlocked(item)
export var MAX_HP = 0
onready var current_hp = MAX_HP

var item_bitmask : int = 0
var disabled_bitmask : int = 0

var on_water = false

# enemy specific babyeeeee 
var target : Node2D
var hp_stacks = 0


func raw_hasitem(item):
	return bool(item_bitmask & item)

func has_item(item):
	return bool(item_bitmask & item) and not bool(disabled_bitmask & item)


func unlocked_item(item):
	if item == GlobalData.Items.HPUP:
		MAX_HP += 1
		current_hp = MAX_HP
		hp_stacks += 1
		
	item_bitmask |= item
	emit_signal("item_unlocked",item)

func _on_NewPlayerDetector_target_detected(target):
	self.target = target
	

func _on_NewPlayerDetector_target_invisible(target):
	if target == self.target:
		self.target = null
