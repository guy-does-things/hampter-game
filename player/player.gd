extends Entity


enum Locations{
	DOOR,
	RECEPTION,
	HOSPITAL_ROOM
}

signal news_recived

onready var fc = $Node2D2
onready var jumpcontroller = $Node2D
export var can_swim = false
var on_p = false
var is_gonna_run = false
var run_time = 0.0
var last_walk_dir = 0
var snap : Vector2

func move():
	velocity = move_and_slide(velocity,Vector2.UP)

func start_moving_in_tube():
	hide()
	$Circlething.hide()
	$AnimatedSprite2.hide()
	can_slide = false
	$StateMachine.set_state($StateMachine/tuberide)
	$PhysicsStuff.friction_enabled = false
	$PhysicsStuff.gravity_enabled = false
	velocity = Vector2.ZERO
	fc.get_node("AnimationPlayer").play("idle")
	
func end_moving_on_tube():
	show()

	can_slide = true
	$StateMachine.set_state($StateMachine/idle)
	$PhysicsStuff.friction_enabled = true
	$PhysicsStuff.gravity_enabled = true


func is_riding():
	return $StateMachine.state == $StateMachine/tuberide

func _physics_process(delta):
	if is_riding():return
	

	
	if is_gonna_run:
		run_time += delta

	var speed = 15
	
	var current_dir_x = sign($"%DirComp".current_dir.x)
	if run_time >= 1 :
		$Circlething.show()
		$AnimatedSprite2.show()
		$DashBreaker.enable()
		$DashBreaker.cast_to.x = 40 * current_dir_x
		$Circlething.rotation_degrees += 32
		speed *= 3
	else:
		$Circlething.hide()
		$AnimatedSprite2.hide()
		$DashBreaker.disable()

	

	
	if last_walk_dir != current_dir_x or current_dir_x == 0 or is_on_wall():
		if is_on_wall() and run_time > 1:
			velocity += Vector2(-last_walk_dir,-.25)*450
		run_time = 0
		
	last_walk_dir = current_dir_x

	velocity.x += current_dir_x * speed
	
	
	
	
	#$"%Armthing".aim($"%DirComp".current_dir,Vector2($"%Armthing".scale.x,0))
	if current_dir_x != 0:
		fc.scale.x = current_dir_x
		$AnimatedSprite2.scale.y = -current_dir_x * 2

	if Input.is_action_just_pressed("jump"):
		jumpcontroller.jump()
		
		
	if Input.is_action_just_released("jump") and velocity.y < 0 :
		velocity.y = 0


	if Input.is_action_pressed("down") and !is_on_floor() and Input.is_action_just_pressed("jump"):
		$StateMachine.set_state($StateMachine/stomp)

	if Input.is_action_just_pressed("attack"):
		$Node2D2/HampterSprite/Halberd.attack()
	
	
	


func _on_Stomp_entered():
	$PhysicsStuff.gravity_enabled = false


func _on_Stomp_exited():
	$PhysicsStuff.gravity_enabled = true


func _on_walk_entered():
	is_gonna_run = true


func _on_walk_exited():
	is_gonna_run = false
	
