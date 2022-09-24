extends Control

signal set_new_word
signal score_added

var word_letter: PackedScene = load("res://fonts/word_letter.tscn")
var type_letter: PackedScene = load("res://fonts/type_letter.tscn")

var current_letter
var letter_index: int = 0
var score: int = 0
var _active_word: String = "" setget set_active_word

onready var word_container = $WordContainer
onready var typing_container = $TypingContainer
onready var score_label = $Score
onready var stability_timer_label = $TimerLabel


func _input(event) -> void:
    if event is InputEventKey and event.pressed:
        var scancode_string = OS.get_scancode_string(event.scancode).to_lower()
        # Validate input key is same as current_letter in the active_word (dont let player mistype)
        if scancode_string != current_letter:
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
            emit_signal("set_new_word")
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
       
    
func _add_score() -> void:
    score += 1
    score_label.text = str(score)
    emit_signal("score_added")
    
    
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
            

func set_active_word(value: String) -> void:
    _active_word = value
    _reset_current_letter()
    _populate_word_container()
