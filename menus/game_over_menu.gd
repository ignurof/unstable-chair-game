extends Control

signal play
signal back_to_main

onready var play_audio = $PlayAudio
onready var quit_audio = $QuitAudio


func _on_Play_pressed() -> void:
    play_audio.play()
    yield(play_audio, "finished")
    emit_signal("play")


func _on_Quit_pressed() -> void:
    quit_audio.play()
    yield(quit_audio, "finished")
    emit_signal("back_to_main")


