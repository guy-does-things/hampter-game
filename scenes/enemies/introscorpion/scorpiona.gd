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


func _on_State_entered():
	play("walk")


func _on_TestScorpionE_entered_hitstun():
	stop()


func _on_Attack_entered():
	play("idle")




func _on_Attack_play_attack_anim():
	play("attack")
