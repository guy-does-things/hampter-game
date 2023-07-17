extends VBoxContainer

var target : Entity



func _ready():
	target = $"../../Entity"

func _process(delta):
	if not is_instance_valid(target):
		$ProgressBar.value = 0
		return
	
	$ProgressBar.value = target.get_node("StatusThing").current_hp
	$ProgressBar.max_value = target.get_node("StatusThing").MAX_HP
	
	pass
