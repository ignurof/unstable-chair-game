extends Control

signal play

onready var options_menu: Control = $OptionsMenu


func _on_Play_pressed():
    emit_signal("play")


func _on_Options_pressed():
    options_menu.set_visible(!options_menu.visible)


func _on_Quit_pressed():
    get_tree().quit()
