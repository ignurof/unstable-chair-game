extends Control

signal play

onready var play_audio = $PlayAudio
onready var quit_audio = $QuitAudio


func _on_Play_pressed():
    play_audio.play()
    yield(play_audio, "finished")
    emit_signal("play")


func _on_Quit_pressed():
    quit_audio.play()
    yield(quit_audio, "finished")
    get_tree().quit()
