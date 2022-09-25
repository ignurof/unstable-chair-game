extends Control

signal play
signal back_to_main


func _on_Play_pressed() -> void:
    emit_signal("play")


func _on_Quit_pressed() -> void:
    emit_signal("back_to_main")


