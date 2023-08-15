class_name DialogThing
extends Resource

export(int,FLAGS,"yes","no") var buttons = 0

export var yes_continuation :Resource
export var no_continuation :Resource
export(String) var button_yes_text = "yes"
export(String) var button_no_text = "no"

export(String,MULTILINE) var text = ""
