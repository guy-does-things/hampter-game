extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func fire_fired(gun):
	stop()
	$"%Bat".frame = 1
	

func Fire_postfired(gun):
	$"%Bat".frame = 0

	


func _on_BloodSuck_entered():
	stop()
	$"%Bat".frame = 5


func _on_BloodSuck_started_dash():
	play("fly")


func _on_WhenSheSuckingYouNutsButYouGangsta_reachedtop():
	stop()
	$"%Bat".frame = 8


func _on_WhenSheSuckingYouNutsButYouGangsta_exited():
	play("fall")


func _on_SuckDownDelay_t_started():
	stop()
	$"%Bat".frame = 0


func _on_TheNoise_moving(ntmup:bool):
	stop()
	$"%Bat".frame = 6 if ntmup else 7


func _on_TheNoise_entered():
	stop()
	$"%Bat".frame = 0




func _on_Entity_entered_hitstun():
	stop()
	$"%Bat".frame = 5



func _on_Entity_exited_hitstun():
	$"%Bat".frame = 0
