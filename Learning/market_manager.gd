extends Node2D


@export var minimun_price = 5
@export var maximun_price = 100
@export var day_length = 10 # seconds

var desired_goods = 6
var market = {}
var events = []

var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

signal update

func _ready():
  var market_timer := Timer.new()
  add_child(market_timer)
  market_timer.timeout.connect(simulate)
  market_timer.autostart = true
  market_timer.one_shot = false
  market_timer.start(day_length)
  simulate()


func simulate():
  adjust_markets()
  generate_event()
  apply_event_effects()
  emit_signal("update")
  
func generate_symbol(length: int):
  var symbol = "$"
  for i in length:
    symbol += alphabet[randi() % len(alphabet)]
  return symbol

func _process(_delta):
  pass
  

func generate_event():
  var symbol = market.keys().pick_random()
  var delta = randi_range(-10,10)
  var duration = randi_range(5,15)
  events.push_back([symbol,delta,duration])
  
func apply_event_effects():
  for event in events:
    if market.has(event[0]):
      market[event[0]] += event[1]
      event[1] += randi_range(-1,1)
      event[2] -= 1
    else:
      event[2] = 0
  var next_events = []
  for event in events:
    if event[2] > 0:
      next_events.push_back(event)
  events = next_events
  
func adjust_markets():
  for symbol in market.keys():
    if market[symbol] <= 0:
      market.erase(symbol)
  while len(market.keys()) < desired_goods:
    create_competition(generate_symbol(randi_range(3,5)))

func create_competition(symbol):
  market[symbol] = randi_range(minimun_price,maximun_price)

