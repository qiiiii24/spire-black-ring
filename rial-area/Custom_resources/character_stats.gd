extends Stats
class_name CharacterStats

const BASE_LEVEL_XP: float = 100

@export_group("Visuals")
@export var character_name: String
@export_multiline var description: String
@export var portrait: Texture

@export_group("Gameplay Data")
## 战斗初始卡组
@export var starting_deck: CardPile
## 角色可以抽的卡组
@export var draftable_cards: CardPile
@export var cards_per_turn: int
@export var max_mana: int
@export var draw_card_cost: int = 3
#@export var starting_relic: Relic

## 弹反(也可以是无敌) #以后设置成status吧
var parry: bool = false : set = set_parry
var parry_id := 0

var experience : int = 100 : set = set_experience
var level : int : 
	get(): return floor(clamp((experience / BASE_LEVEL_XP) + 0.5, 1, 15))
var mana: int : set = set_mana
var deck: CardPile
# 弃牌堆
var discard: CardPile
# 抽牌堆
var draw_pile: CardPile


func set_mana(value: int) -> void:
	mana = clamp(value, 0, max_mana)
	stats_changed.emit()

func set_parry(value: bool) -> void:
	parry = value
	
	#if parry:
		#parry_id += 1
		#var current_id = parry_id
		#
		## 只允许最后一次生效
		#if current_id == parry_id:
			#parry = false

func set_experience(value: int) -> void:
	var old_level: int = level
	experience = value
	
	if not old_level == level:
		recalculate_stats(level)
		print(level)

func reset_mana() -> void:
	mana = 3

func add_experience(enemy: Enemy) -> void:
	experience += enemy.stats.experience

func recalculate_stats(current_level: int) -> void:
	match current_level:
		2:
			max_health += 5
		3:
			max_health += 5
		4:
			max_health += 5
		5:
			max_mana += 1
		6:
			max_health += 5
		7:
			max_health += 5
		8:
			max_health += 5
		9:
			max_health += 5
		10:
			cards_per_turn += 1
		11:
			max_health += 5
		12:
			max_health += 5
		13:
			max_mana += 1
		14:
			max_health += 5
		15:
			draw_card_cost -= 1
		_:
			return

func take_damage(damage: int) -> void:
	var initial_health := health
	super.take_damage(damage)
	if initial_health > health:
		Events.player_hit.emit()


func can_play_card(card: Card) -> bool:
	return mana >= card.cost


func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.cards_per_turn = cards_per_turn
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
