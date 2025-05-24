extends Control

var ringtone_code : String = "0000000000"

var notes = {
	"0" = preload("res://notes/none.ogg"),
	"1" = preload("res://notes/c1.ogg"),
	"2" = preload("res://notes/d.ogg"),
	"3" = preload("res://notes/e.ogg"),
	"4" = preload("res://notes/f.ogg"),
	"5" = preload("res://notes/g.ogg"),
	"6" = preload("res://notes/a.ogg"),
	"7" = preload("res://notes/h.ogg"),
	"8" = preload("res://notes/c2.ogg"),
}

func _ready() -> void:
	# Connects buttons to the main script, so the encoded string is generated every change
	for i in $Notes.get_children():
		i.pressed.connect(encode_buttons)

func encode_buttons() -> void:
	# Resetting the string
	ringtone_code = ""
	# For every button it adds its counter value as a string in the encoded string
	for i : CountableButton in $Notes.get_children():
		ringtone_code += str(i.count)
	$HBoxContainer/LineEdit.set_text(ringtone_code)


func _on_play_pressed() -> void:
	# Compares every character of encoded string with the notes dictionary and plays the note.
	# For this to work every note (including silence) needs to be of the exact same time. Here it is 0.3s
	
	#Loops over every char in the encoded string
	for i in ringtone_code:
		$MusicPlayer.set_stream(notes[i])
		$MusicPlayer.play()
		await $MusicPlayer.finished


func _on_evaluate_pressed() -> void:
	#Gets the string value from the lineedit
	ringtone_code = $HBoxContainer/LineEdit.get_text()
	#Iterates over every char in the string
	for i in range(ringtone_code.length()):
		#Sets the count value to the correct number
		$Notes.get_children()[i].count = int(ringtone_code[i])
		#Sets the label to the correct text
		$Notes.get_children()[i].text = $Notes.get_children()[i].label[int(ringtone_code[i])]
