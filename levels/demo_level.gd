extends Node2D

var word_list: PoolStringArray = []
var _old_word: String = ""

onready var chair: Node2D = $Chair
onready var ui: Control = $UI


func _ready():
    ui.connect("set_new_word", self, "_on_set_new_word")
    chair.rotate_chair()
    word_list = LoadWords.load_to_memory().split("\n")
    
    _start()


func _start() -> void:
    _on_set_new_word()
    ui.stability_timer.start(30.0)


func _randomly_select_word() -> String:
    var random_number: int = randi() % 11
    var new_word: String
    match random_number:
        0:
            new_word = "ignurof"
        1:
            new_word = "hello"
        2:
            new_word = "world"
        3:
            new_word = "boss"
        4:
            new_word = "tree"
        5:
            new_word = "food"
        6:
            new_word = "banana"
        7:
            new_word = "alchemy"
        8:
            new_word = "worldstar"
        9:
            new_word = "programmer"
        10:
            new_word = "developer"
        _:
            push_error("_randomly_select_word: Unhandled random_number case")
            return ""
            
    # HACK: Never use the same word twice recursion
    if _old_word == new_word:
        return _randomly_select_word()
    else:
        return new_word


func _on_set_new_word() -> void:
    ui.set_active_word(_randomly_select_word())
