extends Resource
class_name CardPile

signal card_pile_size_changed(cards_amount)

@export var cards: Array[Card] = []

## 卡组是否为空
func empty() -> bool:
	return cards.is_empty()

## 抽出卡组的第一张卡
func draw_card() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card

## 增加卡牌进卡组
func add_card(card: Card) -> void:
	cards.append(card)
	card_pile_size_changed.emit(cards.size())

## 打乱顺序
func shuffle() -> void:
	cards.shuffle()

## 清空卡组
func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())

## 
func _to_string() -> String:
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_card_strings)
