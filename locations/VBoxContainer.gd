extends VBoxContainer

var target : Entity



func _ready():
	Signals.connect("boss_spawned",self,"boss_spawned")

func boss_spawned(boss,_n):
	target = boss
	$Label.text = _n
	show()

func _process(delta):
	if not is_instance_valid(target):
		hide()
		return
	
	$ProgressBar.value = target.get_node("StatusThing").current_hp
	$ProgressBar.max_value = target.get_node("StatusThing").MAX_HP
	
	pass
