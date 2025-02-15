extends Behavior
class_name Random

func run_child():
	if get_child_count() == 0:
		return
	var childs = find_children("*", "Behavior", false)
	childs.shuffle()
	childs[0].run()
