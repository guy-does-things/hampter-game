extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"d


# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory/GridContainer.playerstatus = $KinematicBody2D/StatusThing
	$Inventory/InventoryBorder.setup_player($KinematicBody2D,$KinematicBody2D/StatusThing)



