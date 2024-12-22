class_name DW_Logger
extends Node

# Logs an informational message
func info(name: String, text: String) -> void:
	print("[INFO][" + name + "] " + text)
	GDConsole.print_line("[INFO][" + name + "] " + text)

func warn(name: String, text: String) -> void:
	pass

func error(name: String, text: String) -> void:
	print("[1;91m" + "[ERROR][" + name + "] " + text + "[0;37m")
	GDConsole.print_error("[ERROR][" + name + "] " + text)
