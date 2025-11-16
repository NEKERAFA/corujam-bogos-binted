extends Node


## Number of worm parts
var n_parts: int = 5
## Number of delayed frames between parts
var n_frames: int = 6
## Offset between parts
var offset: float = 28.0
## Maximum vertical distance between parts
var max_distance: float = 25.0
## Maximum rotation of parts (different from head)
var max_rotation: float = deg_to_rad(35)
## The highest point underground
var min_depth: float = 100.0
## The deepest point underground
var max_depth: float = 500.0
