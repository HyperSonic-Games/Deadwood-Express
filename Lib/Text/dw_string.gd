

extends Node
class_name DWString

# DWString: A class for seamless integration of translatable strings with dynamic argument replacement.
#
# Description:
#   - DWString acts like a normal string but automatically integrates with Godot's translation system.
#   - It supports placeholders in translation keys that can be replaced dynamically at runtime.
#
# Features:
#   - Dynamic argument replacement using `{key}` placeholders.
#   - Transparent usage in string operations like concatenation and comparison.
#   - Simplifies localization by encapsulating translation logic.
#
# Usage for Developers:
# 1. Add translations in your `.po` or `.csv` file with placeholders (e.g., `greeting = "Hello, {name}!"`).
# 2. Create a DWString instance with a key and optional arguments:
#    ```
#    var greeting = DWString.new("greeting", {"name": "Alice"})
#    print(greeting)  # Output: "Hello, Alice!"
#    ```
# 3. Use DWString wherever a normal string is expected:
#    ```
#    print("Message: " + greeting)
#    ```

# === MODDER'S NOTES ===
# Name stands for Deadwood Express String
# To use this in a modding context:
# 1. Ensure the translation keys for your mod's strings are added to the project's translation files.
# 2. Create a new DWString with the appropriate key and arguments.
# 3. Use the DWString instance in scripts or UI elements.
# Example for modders:
# ```
# var mod_message = DWString.new("mod_key", {"player": "John"})
# print(mod_message)  # Will output the translated and formatted string.
# ```


# === CLASS IMPLEMENTATION ===

# Internal key for the string
var _key: String = ""  # Default empty string
var _arguments: Dictionary = {}  # Arguments for placeholder replacement

# Create a new DWString instance
static func new(key: String, arguments: Dictionary = {}) -> DWString:
	var instance = DWString.new()
	instance._key = key
	instance._arguments = arguments
	return instance

# Setter for the key
func set_key(value: String) -> void:
	_key = value

# Getter for the key
func get_key() -> String:
	return _key

# Setter for arguments
func set_arguments(value: Dictionary) -> void:
	_arguments = value

# Getter for arguments
func get_arguments() -> Dictionary:
	return _arguments

# Translate and replace placeholders with arguments
func as_string() -> String:  # Renamed from `to_string()` to `as_string()`
	var translated_text = tr(_key)
	if _arguments.size() > 0:
		# Replace placeholders like `{key}` with corresponding argument values
		for arg_key in _arguments.keys():
			translated_text = translated_text.replace("{" + arg_key + "}", str(_arguments[arg_key]))
	return translated_text

# Overload operators to behave like a string
func __str__() -> String:
	return as_string()  # Use `as_string()` for string conversion

func __add__(other) -> String:
	return as_string() + str(other)

func __eq__(other) -> bool:
	return as_string() == str(other)
