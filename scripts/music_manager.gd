extends Node


func play_music(id):
	var selected: AudioStreamPlayer
	halt_all_music()
	match id:
		"Gameplay": selected = $GameplayMusic
		"Win": selected = $WinMusic
		"GameOver": selected = $GameOverMusic
	selected.play()

func halt_all_music():
	for node in get_children():
		node.stop()
