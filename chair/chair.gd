extends Node2D

onready var anim_player: AnimationPlayer = $AnimationPlayer


func rotate_chair() -> void:
    anim_player.play("test")


# 0 - 25s+ | 1 - 20s+
# 2 - 15s+ | 3 - 10s+
# 4 - 5s+  | 5 - 0s+
func animate(stage: int) -> void:
    match stage:
        0:
            pass
        1:
            pass
        2:
            pass
        3:
            pass
        4:
            pass
        5:
            pass
        _:
            push_error("chair animate(): unhandled stage value in match")
