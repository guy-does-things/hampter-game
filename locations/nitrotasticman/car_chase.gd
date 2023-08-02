extends NewestRoom


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	for BG in $BGS.get_children():
		for BGpart in BG.get_children():
			if "speed" in BGpart:
				create_tween().tween_property(
					BGpart,
					"speed",
					0,
					.5
				).set_trans(Tween.TRANS_LINEAR)
	
