extends CanvasLayer

var gametime :int= 0;
var started = false

func _physics_process(delta):
	if !get_tree().paused and started:

		gametime += delta * 1000
	
	
	#$"%SPRTime".

func FormatTime(timeMS):
	var timeSecsInt = (timeMS / 1000);
	
	var mins = timeSecsInt / 60
	var secs = timeSecsInt % 60;
	var ms = (timeMS / 10) % 100
	
	var hours = mins/60
	mins = mins % 60
	return "%02d:%02d:%02d:%02d" % [hours,mins, secs, ms]
