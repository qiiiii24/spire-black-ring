extends Stats
class_name CharacterStats

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
#@export var starting_relic: Relic

var mana: int : set = set_mana
var deck: CardPile
# 抽牌堆
var discard: CardPile
# 弃牌堆
var draw_pile: CardPile


func set_mana(value: int) -> void:
	mana = clamp(value, 0, max_mana)
	stats_changed.emit()


func reset_mana() -> void:
	mana = 3


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
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
