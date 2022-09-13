extends Node
# Main entrypoint to the program (game)

onready var main_menu: Control = load("res://menus/main_menu.tscn").instance()
onready var demo_level: Node2D = load("res://levels/demo_level.tscn").instance()


func _ready() -> void:
    main_menu.connect("play", self, "_on_play")
    add_child(main_menu)
    
    
func _on_play() -> void:
    get_child(0).queue_free()
    add_child(demo_level)
