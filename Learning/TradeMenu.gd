extends Panel


var symbol_listing = preload("res://stock_listing_gui.tscn")
var content_visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
  MarketManager.update.connect(update_listing)
 # visible = false
  manage_visibilty()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  $CashLabel.text = "$" + str(PlayerVars.cash)

func update_listing():
  var active_symbols = MarketManager.market.keys()
  var found_keys = []
  for c in $ScrollContainer/SymbolList.get_children():
    if c.symbol_name in active_symbols:
      found_keys.push_back(c.symbol_name)
    else:
      c.queue_free()
  active_symbols = active_symbols.filter(func(x): return x not in found_keys)
  for symbol in active_symbols:
    var listing = symbol_listing.instantiate()
    $ScrollContainer/SymbolList.add_child(listing)
    listing.visible = content_visible
    listing.set_symbol_name(symbol)
    
func manage_visibilty():
  for c in get_children():
    c.visible = content_visible


func get_listing(symbol):
  for c in $ScrollContainer/SymbolList.get_children():
    if symbol == c.symbol_name:
      return c


func _on_button_toggled(toggled_on):
  content_visible = toggled_on
  manage_visibilty()
