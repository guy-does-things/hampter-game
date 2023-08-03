extends "res://boss.gd"

var outline_colors =[
	Color.black,
	Color.white,	
]

signal tired()
signal recharged()
var recharging = false

export var o_color = 0.0 setget set_ocolor; func set_ocolor(val):
	if not is_inside_tree():return
	
	o_color = val
	$Flippables/Glock/SpriteSheet.material.set_shader_param("rep_col",outline_colors[int(o_color)%2])
	pass

func _ready():
	$"%Halb".playerstatus = $StatusThing

func _process(delta):
	$Label.rect_position.x = $Label.rect_size.x / -2
	$Label.text = str("stamina",$StatusThing.stamina,"\n", "State:",$StateMachine.state)


func _physics_process(delta):
	if $"%StatusThing".stamina == 0 and not recharging:
		recharging = true 
		emit_signal("tired")
		yield(get_tree().create_timer(5.0/$"%StatusThing".stamina_regen,false),"timeout")
		$"%StatusThing".stamina = $"%StatusThing".MAX_STAMINA
		emit_signal("recharged")
		recharging = false
