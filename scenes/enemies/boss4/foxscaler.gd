extends Node2D

const YPOS = 12
export var go_up_tweenT = .6
export var tweenT = .6
var animating = false
export var can_a = false
var tween1 :SceneTreeTween
var tween2 :SceneTreeTween


func _physics_process(delta):
	if can_a:
		animate()


func animate():
	if animating:return
	animating = true
	tween1 = create_tween()
	tween2 = create_tween()
	
	tween1.tween_property(self,"scale:y",1.2, go_up_tweenT)
	tween2.tween_property(self,"position:y",8, go_up_tweenT)
	yield(tween2,"finished")

	tween1 = create_tween()
	tween2 = create_tween()
	tween1.tween_property(self,"scale:y",1, tweenT)
	tween2.tween_property(self,"position:y",12, tweenT)
	yield(tween2,"finished")
	
	animating = false


func stop():
	if tween1:tween1.stop()
	if tween2:tween2.stop()
	
	position.y = 12
	scale.y = 1
	can_a = false
	animating = false


func start():
	can_a = true
