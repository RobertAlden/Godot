extends Node2D


var chars_per_segment = 3.8
var text_index = 0
var content_string = "Test String"
var display_string = ""

func create_sprites():
  var num_segments = ceil(len(content_string) / chars_per_segment)
  var segments = []
  segments.resize(num_segments)
  segments.fill(1)
  segments[0] = 0
  segments[-1] = 3
  segments[num_segments/2] = 2
  for i in range(len(segments)):
    var piece = $BoxComponents.duplicate()
    $Box.add_child(piece)
    piece.visible = true
    piece.frame = segments[i]
    piece.position.x += (i*16)
  $Box.position.x -= num_segments * 16 / 2
  $Box.position.y -= 24
  $Box/RichTextLabel.size = Vector2(num_segments*chars_per_segment*32,48)
    
# Called when the node enters the scene tree for the first time.
func _ready():
  $Box/RichTextLabel.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass


func _on_timer_timeout():
  queue_free()
  QuestManager.textbox_spawned = false


func _on_text_timer_timeout():
  if text_index < len(content_string):
    $Box/RichTextLabel.append_text(content_string[text_index])
    text_index += 1
  else:
    $Timer.start()
    $TextTimer.queue_free()
