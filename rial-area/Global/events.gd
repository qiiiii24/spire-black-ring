extends Node

# 开牌瞄准开始|结束信号
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
#  开牌拖动开始|结束信号
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
