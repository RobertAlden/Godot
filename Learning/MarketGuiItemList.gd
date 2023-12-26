extends VBoxContainer


var symbol_listing = preload("res://stock_listing_gui.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
  MarketManager.update.connect(update_listing)
  visible = false
  manage_visibilty()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass

func update_listing():
  var active_symbols = MarketManager.market.keys()
  var found_keys = []
  for c in get_children():
    if c.symbol_name in active_symbols:
      found_keys.push_back(c.symbol_name)
    else:
      c.queue_free()
  active_symbols = active_symbols.filter(func(x): return x not in found_keys)
  for symbol in active_symbols:
    var listing = symbol_listing.instantiate()
    add_child(listing)
    listing.visible = self.visible
    listing.set_symbol_name(symbol)
    
func manage_visibilty():
  for c in get_children():
    c.visible = self.visible


func _on_button_toggled(toggled_on):
  self.visible = toggled_on
  manage_visibilty()
