extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


func get_tiles_at(loc: Vector2, tmap: TileMap, layername: String):
  var cell_loc = tmap.local_to_map(tmap.to_local(loc))
  for i in range(tmap.get_layers_count()):
    if tmap.get_layer_name(i) == layername:
      var data = tmap.get_cell_tile_data(i, cell_loc)
      return data


func get_input():
  if Input.get_action_strength("Interact") != 0:
    var tile = get_tiles_at($Level/Player.global_position, $Level, "buildings")
    if tile != null:
      QuestManager.start_quest()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  get_input()
