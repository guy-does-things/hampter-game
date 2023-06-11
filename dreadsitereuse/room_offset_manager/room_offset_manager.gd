extends Control



class TestGraph extends GraphNode:
	pass

func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE,Vector2(480,270))
#
	for i in NewRoomAutoload.room_dictionary.keys():
		$NewMapScreen.added_room(i.resource_path, 3)

