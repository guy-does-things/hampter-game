extends Panel

onready var l = $Label


func _physics_process(delta):
	visible = SavesManager.settings.igt
	l.text = str(Igt.FormatTime(Igt.gametime))
