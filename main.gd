extends Node
# Main entrypoint to the program (game)

onready var main_menu: Control = load("res://menus/main_menu.tscn").instance()


func _ready() -> void:
    add_child(main_menu.instance())
