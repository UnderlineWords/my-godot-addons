@tool
class_name GalaxyGeneratorPlugin
extends EditorPlugin

var inspector_plugin = GalaxyGeneratorInspector.new()

func _enter_tree():
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	inspector_plugin.free()
