extends Node2D

var word_list: PoolStringArray = []
var _old_word: String = ""

onready var chair: Node2D = $Chair
onready var ui: Control = $UI
onready var stability_timer = $StabilityTimer


func _ready():
    randomize()
    ui.connect("set_new_word", self, "_on_set_new_word")
    
    word_list = LoadWords.load_to_memory().split("\n")
    _start()


func _process(delta) -> void:
    ui.stability_timer_label.set_text(str(stability_timer.get_time_left()))


func _start() -> void:
    _on_set_new_word()
    stability_timer.start(30.0)
    chair.animate(0)


func _randomly_select_word() -> String:
    var new_word = "ignurof"
    var rand_num = randi() % len(word_list)
    new_word = word_list[rand_num]
            
    # HACK: Never use the same word twice recursion
    if _old_word == new_word:
        return _randomly_select_word()
    else:
        return new_word


func _on_set_new_word() -> void:
    ui.set_active_word(_randomly_select_word())
