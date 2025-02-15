extends Node
class_name Behavior

enum RunType {
	UNHANDLED_INPUT,
	PROCESS,
	PHYSICS
}

var run_type := RunType.PROCESS

func run():
	run_child()

func run_child():
	if get_child_count() == 0:
		return
	var childs =  find_children("*", "Behavior", false)
	childs[0].run()
