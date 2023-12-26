extends Panel

var symbol = "$STONK"
var quantity = 0
var reward = 0

signal submitted(id)
signal abandoned

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  %Symbol.text = "Symbol: " + symbol
  %Quantity.text = "Requested: " + str(quantity)
  %Reward.text = "Reward: " + str(reward)
  var tm = get_node("/root/Main/GUI/TradeMenu").get_listing(symbol)
  if tm != null:
    %Submit.disabled = tm.quantity < quantity
    
func _on_submit_pressed():
  emit_signal("submitted", self)


func _on_abandon_pressed():
  emit_signal("abandoned", self)
  queue_free()
