extends Draggable

var letter: String

func set_letter(l: String):
	self.letter = l
	$Label.text = l
