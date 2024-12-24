class_name DW_EventBus
extends Node

# Dictionary to hold event subscribers
var subscribers: Dictionary = {}

# Reference to the logger
@onready var Logger: DW_Logger = DW_Logger.new()

# Called when the node enters the scene tree
func _ready() -> void:
	pass

# Subscribe to an event
func subscribe(event_name: String, callback: Callable) -> void:
	if not subscribers.has(event_name):
		subscribers[event_name] = []
		Logger.info("DW_EVENT_BUS", "Created new event: " + event_name)
	if callback in subscribers[event_name]:
		Logger.info("DW_EVENT_BUS", "Callback already subscribed to event: " + event_name)
		return
	subscribers[event_name].append(callback)
	Logger.info("DW_EVENT_BUS", "Subscribed to event: " + event_name + " | Total callbacks: " + str(subscribers[event_name].size()))

# Publish an event
func publish(event_name: String, data: Variant = null) -> void:
	if not subscribers.has(event_name):
		Logger.warn("DW_EVENT_BUS", "No subscribers for event: " + event_name)
		return
	Logger.info("DW_EVENT_BUS", "Publishing event: " + event_name + " | Data: " + str(data))
	for callback in subscribers[event_name]:
		if callback.is_valid():
			callback.call(data)
		else:
			Logger.error("DW_EVENT_BUS", "Invalid callback removed from event: " + event_name)
			subscribers[event_name].erase(callback)

# Unsubscribe from an event
func unsubscribe(event_name: String, callback: Callable) -> void:
	if subscribers.has(event_name):
		if callback in subscribers[event_name]:
			subscribers[event_name].erase(callback)
			Logger.info("DW_EVENT_BUS","Unsubscribed from event: " + event_name + " | Remaining callbacks: " + str(subscribers[event_name].size()))
		else:
			Logger.warn("DW_EVENT_BUS","Callback not found for event: " + event_name)
	else:
		Logger.error("DW_EVENT_BUS","Event not found: " + event_name)
