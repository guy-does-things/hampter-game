class_name StatusThing
extends Node


export var MAX_HP = 0
onready var current_hp = MAX_HP

var item_bitmask : int

# enemy specific babyeeeee 
var target : Node2D


func has_item(item):
	return bool(item_bitmask & item)

func unlocked_item(item):
	item_bitmask |= item

func _on_NewPlayerDetector_target_detected(target):
	self.target = target
	

func _on_NewPlayerDetector_target_invisible(target):
	if target == self.target:
		self.target = null
