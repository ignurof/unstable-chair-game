extends Control

var word_letter: PackedScene = load("res://fonts/word_letter.tscn")
var type_letter: PackedScene = load("res://fonts/type_letter.tscn")

var active_word: String = ""
var current_letter
var letter_index: int = 0
var score: int = 0

onready var word_container = $WordContainer
onready var typing_container = $TypingContainer
onready var score_label = $Score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()
    active_word = _randomly_select_word()
    current_letter = active_word[letter_index]
    
    for letter in active_word:
        var new_letter: Label = word_letter.instance()
        new_letter.text = letter
        word_container.add_child(new_letter)


func _input(event) -> void:
    if event is InputEventKey and event.pressed:
        var scancode_string = OS.get_scancode_string(event.scancode).to_lower()
        # Validate input key is same as current_letter in the active_word (dont let player mistype)
        if scancode_string != current_letter:
            print("Wrong letter!")
            return
            
        var new_letter: Label = type_letter.instance()
        new_letter.text = scancode_string
        typing_container.add_child(new_letter)
        printt(letter_index, current_letter, active_word.length())
        letter_index += 1
        if letter_index < active_word.length():
            current_letter = active_word[letter_index]
        else:
            # Gain score and update word
            current_letter = null
            score += 1
            score_label.text = str(score)
            # TODO: Set chair balance
            
            

func _randomly_select_word() -> String:
    var random_number: int = randi() % 11
    match random_number:
        1:
            return "hello"
        2:
            return "world"
        3:
            return "boss"
        4:
            return "tree"
        5:
            return "food"
        6:
            return "banana"
        7:
            return "alchemy"
        8:
            return "worldstar"
        9:
            return "programmer"
        10:
            return "developer"
        _:
            push_error("_randomly_select_word: Unhandled random_number case")
            return ""
