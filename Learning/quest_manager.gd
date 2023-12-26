extends Node2D



var greetings = ["hello", "howdy", "salutations", "hi", "yo", "hey there" ]
var titles = ["you", "dude", "pal", "friendo", "chap", "chum", "buddy"]
var requests = ["would you mind getting", "we really need", "please acquire", "go get me", "i want", "we would like"]
var signoffs = ["thanks", "alright, now scram", "thank you kindly", "now, hurry", "it's urgent"]
var tones = [".", "...", "!", "?!", "!!!", ". :)", "~", ". :V", "! :D"]

var active_quests = {}

var textbox_spawned = false
@onready var textbox = preload("res://textbox.tscn")
var profit_margin = 1.5

func generate_request(item):
  var quantity = active_quests[item] 
  return str(quantity) + " units of " + item

func capitalize(phrase: String):
  var words = phrase.split(" ")
  words[0] = words[0].capitalize()
  return " ".join(words)

func generate_line(greeting, title, request, signoff, tone1, tone2):
  var line = ""
  var space = " "
  line += capitalize(greeting) + "," + space
  line += title + tone1 + space
  line += capitalize(request) + "," + space
  line += signoff + tone2
  return line

func start_quest():
  var greeting = greetings.pick_random()
  var title = titles.pick_random()
  var item = MarketManager.market.keys().pick_random()
  var quantity = randi_range(1, 15)
  active_quests[item] = quantity
  var reward = ceil(MarketManager.market[item] * quantity * profit_margin)
  var request = generate_request(item)
  var signoff = signoffs.pick_random()
  var tone1 = tones.pick_random()
  var tone2 = tones.pick_random()
  var speech = generate_line(greeting, title, request, signoff, tone1, tone2)
  get_node("/root/World/Level/Player/CanvasLayer/QuestMenu").add_quest(item, quantity, reward)
  spawn_text(speech)

func spawn_text(content):
  if not textbox_spawned:
    var text = textbox.instantiate()  
    add_child(text)
    text.position = get_node("/root/World/Level/Player").global_position
    text.content_string = content
    text.create_sprites()
    textbox_spawned = true

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
