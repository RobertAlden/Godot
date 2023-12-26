extends Control

var quantity = 0
var value = 0
var symbol_name = "$STONK"
var purchases = []
# Called when the node enters the scene tree for the first time.
func _ready():
  MarketManager.update.connect(update_labels)

func update_labels():
  if MarketManager.market.has(symbol_name):
   $HSplitContainer/InfoPanel/SymbolLabel.text = symbol_name
   value = MarketManager.market[symbol_name]
   $HSplitContainer/InfoPanel/CurrentPrice.text = "$" + str(value)
  if len(purchases) > 0:
    $HSplitContainer/InfoPanel/AveragePrice.text = "$" + str(ceil(purchases.reduce(func(a,x):return a+x)/len(purchases)))
  else:
    $HSplitContainer/InfoPanel/AveragePrice.text = "$0"
  if quantity < 0:
    quantity = 0
  $HSplitContainer/TradePanel/QuantityLabel.text = str(quantity)


func set_symbol_name(s : String):
  symbol_name = s
  update_labels()


func purchase(amount: int):
  if PlayerVars.cash - amount*value >= 0:
    quantity += amount
    PlayerVars.cash -= amount*value
    var arr = []
    arr.resize(amount)
    arr.fill(value)
    purchases.append_array(arr)
    update_labels()
    

func sell(amount: int):
  if quantity >= amount:
    quantity -= amount
    PlayerVars.cash += amount * value
    purchases.pop_front()
    update_labels()


func _on_less_button_pressed():
  sell(1)
  
func _on_more_button_pressed():
  purchase(1)
