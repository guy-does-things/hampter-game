class_name StatusThing
extends Node


signal item_unlocked(item,lg)
export var MAX_HP = 0 setget ,get_max_hp
onready var current_hp = MAX_HP setget set_cur_hp



var item_bitmask : int = 0
var disabled_bitmask : int = 0
var hp_stacks = 0

var on_water = false

# enemy specific babyeeeee 
var target : Node2D
export var MAX_STAMINA = 0
export var stamina_regen = 2
onready var stamina = MAX_STAMINA


func decrease_stamina(dec):
	stamina = max(0,stamina-dec)
	
func is_full():
	return stamina == MAX_STAMINA


func raw_hasitem(item):
	return bool(item_bitmask & item)

func has_item(item):
	return bool(item_bitmask & item) and not bool(disabled_bitmask & item)


func get_max_hp():
	return MAX_HP + hp_stacks

func set_cur_hp(nhp):
	current_hp = min(nhp,get_max_hp())


func unlocked_item(item,loadedgame=false):
	if item == GlobalData.Items.HPUP:
		hp_stacks += 2
		current_hp = self.MAX_HP
	if item == GlobalData.Items.HPUPONE:
		hp_stacks += 1
		current_hp = self.MAX_HP
		
	item_bitmask |= item
	emit_signal("item_unlocked",item,loadedgame)



func _on_NewPlayerDetector_target_detected(target):
	self.target = target
	

func _on_NewPlayerDetector_target_invisible(target):
	if target == self.target:
		self.target = null
