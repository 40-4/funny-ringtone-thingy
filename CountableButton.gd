extends Button
class_name CountableButton

var label : Array = ["-", "C1", "D", "E", "F", "G", "A", "H", "C2"]

var count : int = 0

func _ready() -> void:
	self.pressed.connect(add_count)


func add_count() -> void:
	count += 1
	count = count % label.size()
	
	self.set_text(label[count])
