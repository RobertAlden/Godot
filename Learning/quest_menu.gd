extends Panel


var quest_item = preload("res://quest_item.tscn")
var TradeMenu = null 
# Called when the node enters the scene tree for the first time.
func _ready():
  TradeMenu = get_node("/root/World/Level/Player/CanvasLayer/TradeMenu")
  unique_name_in_owner = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
  
func add_quest(symbol,quantity,reward):
  var qi = quest_item.instantiate()
  $VBoxContainer.add_child(qi)
  qi.symbol = symbol
  qi.quantity = quantity
  qi.reward = reward
  qi.submitted.connect(complete_quest)
  
func complete_quest(id):
  PlayerVars.cash += id.reward
  var stock_listing = TradeMenu.get_listing(id.symbol)
  stock_listing.quantity -= id.quantity
  stock_listing.update_labels()
  id.queue_free()
