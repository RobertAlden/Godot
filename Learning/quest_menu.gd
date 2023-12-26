extends VBoxContainer


var quest_item = preload("res://quest_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
  MarketManager.update.connect(expired_stale_quests)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
  

func expired_stale_quests():
  for qi in %QuestList.get_children():
    if not MarketManager.market.has(qi.symbol):
        qi.queue_free()

func add_quest(symbol,quantity,reward):
  var qi = quest_item.instantiate()
  %QuestList.add_child(qi)
  qi.symbol = symbol
  qi.quantity = quantity
  qi.reward = reward
  qi.submitted.connect(complete_quest)
  
func complete_quest(qid):
  PlayerVars.cash += qid.reward
  var tm = get_node("/root/Main/GUI/TradeMenu").get_listing(qid.symbol)
  if tm != null:
    tm.remove_purchases(qid.quantity)
  qid.queue_free()


func _on_display_toggled(toggled_on):
  %QuestList.visible = toggled_on
