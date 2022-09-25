extends Node
# Main entrypoint to the program (game)

var main_menu: Control
var game_over_menu: Control 
var demo_level: Node2D


func _ready() -> void:
   _main_menu()
    
    
func _main_menu() -> void:
    main_menu = load("res://menus/main_menu.tscn").instance()
    main_menu.connect("play", self, "_on_play")
    add_child(main_menu)
    
    
func _game_over_menu() -> void:
    game_over_menu = load("res://menus/game_over_menu.tscn").instance()
    game_over_menu.connect("play", self, "_on_play")
    game_over_menu.connect("back_to_main", self, "_on_back_to_main")
    add_child(game_over_menu)
    
    
func _on_back_to_main() -> void:
    _remove_active_scene()
    _main_menu()
    
    
func _on_play() -> void:
    _remove_active_scene()
    demo_level = load("res://levels/demo_level.tscn").instance()
    demo_level.connect("game_over", self, "_on_game_over")
    add_child(demo_level)


func _on_game_over() -> void:
    _remove_active_scene()
    _game_over_menu()
    
    
func _remove_active_scene() -> void:
    if get_child_count() > 0:
        get_child(0).queue_free()
