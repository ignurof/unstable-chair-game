extends Node2D

signal game_over

var word_list: PoolStringArray = []
var _old_word: String = ""

onready var chair: Node2D = $Chair
onready var ui: Control = $UI
onready var stability_timer: Timer = $StabilityTimer


func _ready() -> void:
    randomize()
    ui.connect("set_new_word", self, "_on_set_new_word")
    ui.connect("score_added", self, "_on_score_added")
    
    word_list = LoadWords.load_to_memory().split("\n")
    _start()


func _process(delta) -> void:
    ui.stability_timer_label.set_text(str(stability_timer.get_time_left()))
    
    # Animation stages
    if stability_timer.get_time_left() >= 25.0:
        chair.animate(0)
    elif stability_timer.get_time_left() >= 20.0:
        chair.animate(1)
    elif stability_timer.get_time_left() >= 15.0:
        chair.animate(2)
    elif stability_timer.get_time_left() >= 10.0:
        chair.animate(3)
    elif stability_timer.get_time_left() >= 5.0:
        chair.animate(4)
    elif stability_timer.get_time_left() > 0.0:
        chair.animate(5)


func _start() -> void:
    _on_set_new_word()
    stability_timer.start(10.0)
    chair.animate(0)


func _randomly_select_word() -> String:
    var new_word = word_list[randi() % len(word_list)]
    
    if _old_word != new_word:
        return new_word
    else:
        return _randomly_select_word()


func _on_set_new_word() -> void:
    ui.set_active_word(_randomly_select_word())
    
    
func _on_score_added() -> void:
    stability_timer.start(stability_timer.get_time_left() + 5.0)
    
    if chair.get_stage() > 0:
        chair.animate(chair.get_stage() - 1)


func _game_over() -> void:
    emit_signal("game_over")


func _on_StabilityTimer_timeout() -> void:
    _game_over()
