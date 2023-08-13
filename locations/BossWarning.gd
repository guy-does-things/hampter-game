extends Control


export(NodePath) onready var invl = get_node(invl)
export(NodePath) onready var plr = get_node(plr)

var is_doing_thing = false


func _ready():
	Signals.connect("boss_spawned",self,"warning_popup")

func boss_spawned(boss,_n):
	print("?#")
	warning_popup(boss)


func warning_popup(boss=null,n=""):
	if is_doing_thing:return
	plr.on_wning = true
	show()
	is_doing_thing = true
	invl.hide()
	$Label.percent_visible = 0
	
	yield(create_tween().tween_property(
		$Label,
		"percent_visible",
		1.0,
		1
	),"finished")
	yield(get_tree().create_timer(.5,false),"timeout")
	yield(create_tween().tween_property(
		$Label,
		"percent_visible",
		.0,
		1
	),"finished")

	is_doing_thing = false
	hide()
	plr.on_wning = false
	invl.show()
	yield(get_tree().create_timer(.1,false),"timeout")
	
	if boss:
		boss.can_trans()



	
	
	
