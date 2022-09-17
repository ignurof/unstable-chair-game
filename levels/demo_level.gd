extends Node2D

var word_list

onready var chair: Node2D = $Chair


func _ready():
    chair.rotate_chair()
    word_list = LoadWords.load_to_memory()
    print(word_list)
