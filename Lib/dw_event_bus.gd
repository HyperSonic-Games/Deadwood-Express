class_name DW_EventBus
extends Node

# Dictionary to hold event subscribers
var subscribers: Dictionary = {}

# Reference to the logger
var Logger: DW_Logger = null

# Called when the node enters the scene tree
func _ready() -> void:
	# Ensure Logger is available
	Logger = get_node_or_null("/root/DW_Logger")
	if Logger == null:
		print("Logger not found! Ensure DW_Logger is set up as a global node.")

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
	Logger.info("Publishing event: " + event_name + " | Data: " + str(data))
	for callback in subscribers[event_name]:
		if callback.is_valid():
			callback.call(data)
		else:
			log("Invalid callback removed from event: " + event_name)
			subscribers[event_name].erase(callback)

# Unsubscribe from an event
func unsubscribe(event_name: String, callback: Callable) -> void:
	if subscribers.has(event_name):
		if callback in subscribers[event_name]:
			subscribers[event_name].erase(callback)
			log("Unsubscribed from event: " + event_name + " | Remaining callbacks: " + str(subscribers[event_name].size()))
		else:
			log("Callback not found for event: " + event_name)
	else:
		log("Event not found: " + event_name)

# Helper function to log messages using the logger
func log(message: String) -> void:
	if Logger != null:
		Logger.info("DW_EventBus", message)
	else:
		print("[DW_EventBus] " + message)
