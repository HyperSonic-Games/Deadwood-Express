class_name DW_Logger
extends Node

# Logs an informational message
func info(logger_name: String, text: String) -> void:
	print("[INFO][" + logger_name + "] " + text)
	GDConsole.print_line("[INFO][" + name + "] " + text)

func warn(logger_name: String, text: String) -> void:
	print_rich("[color=orange] [WARN/" + logger_name + "] " + text + "[/color]")

func error(logger_name: String, text: String) -> void:
	print("[1;91m" + "[ERROR][" + logger_name + "] " + text + "[0;37m")
	GDConsole.print_error("[ERROR][" + logger_name + "] " + text)
