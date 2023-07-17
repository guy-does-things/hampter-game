extends Sprite

func _ready():
	$AnimationPlayer.playback_speed *= rand_range(.9,1.1)
