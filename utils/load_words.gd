class_name LoadWords
extends Node
# Simply read from wordlist.txt and return the list


static func load_to_memory():
    var file = File.new()
    file.open("res://wordlist.txt", File.READ)
    var content = file.get_as_text()
    file.close()
    return content
