extends Control

var word_letter: PackedScene = load("res://fonts/word_letter.tscn")
var type_letter: PackedScene = load("res://fonts/type_letter.tscn")

var current_letter
var letter_index: int = 0
var score: int = 0
var _active_word: String = "" setget _set_active_word
var _old_word: String = ""

onready var word_container = $WordContainer
onready var typing_container = $TypingContainer
onready var score_label = $Score
onready var stability_timer = $StabilityTimer
onready var stability_timer_label = $StabilityTimer/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()
    _set_active_word(_randomly_select_word())
    
    _populate_word_container()
    
    stability_timer.start(30.0)
    
    
func _process(delta) -> void:
    # TODO: Fail condition
    if stability_timer.get_time_left() <= 0.1:
        print("fail condition")

    stability_timer_label.text = str(stability_timer.get_time_left())


func _input(event) -> void:
    if event is InputEventKey and event.pressed:
        var scancode_string = OS.get_scancode_string(event.scancode).to_lower()
        # Validate input key is same as current_letter in the active_word (dont let player mistype)
        if scancode_string != current_letter:
            print("Wrong letter!")
            # If player is not on the first letter, reset
            if letter_index > 0:
                _reset_typing()
            return
            
        var new_letter: Label = type_letter.instance()
        new_letter.text = scancode_string
        typing_container.add_child(new_letter)
        letter_index += 1
        if letter_index < _active_word.length():
            current_letter = _active_word[letter_index]
        else:
            # Gain score and update word
            _add_score()
            _set_new_active_word()
            _reset_typing()
            # TODO: Set chair balance
           
        
func _reset_typing() -> void:
    current_letter = null
    for child in typing_container.get_children():
        child.queue_free()

    _reset_current_letter()
    

func _reset_current_letter() -> void:
    letter_index = 0
    current_letter = _active_word[letter_index]


# TODO: Make this more better
func _set_new_active_word() -> void:
    _set_active_word(_randomly_select_word())
    _populate_word_container()
        
    
func _add_score() -> void:
    score += 1
    score_label.text = str(score)
    
    
func _populate_word_container() -> void:
    # Delete old word
    if word_container.get_child_count() > 0:
        for child in word_container.get_children():
            child.queue_free()
    
    # Add new word
    for letter in _active_word:
        var new_letter: Label = word_letter.instance()
        new_letter.text = letter
        word_container.add_child(new_letter)
            

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


func _set_active_word(value: String) -> void:
    _active_word = value
    _old_word = _active_word
    _reset_current_letter()
