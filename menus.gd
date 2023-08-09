extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_GamePanel_menu_exited()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$GamePanel.show()
	$GamePanel.menu_shown()


func _on_GamePanel_menu_exited():
	if $VBoxContainer.last_thing_grabbed:
		$VBoxContainer.last_thing_grabbed.grab_focus()
	else:
		$VBoxContainer/Button.grab_focus()
		


func _on_Button2_pressed():
	$Settings.show()
	$Settings.selected()
