extends Panel

var symbol = "$STONK"
var quantity = 0
var reward = 0

signal submitted(id)

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  $Symbol.text = symbol
  $Quantity.text = "Requested: " + str(quantity)
  $Reward.text = "Reward: " + str(reward)
  $Submit.disabled = false
  
func _on_submit_pressed():
  emit_signal("submitted", self)
