extends "res://Scenes/SceneBase.gd"

var savedText = ""

func _init():
	sceneID = "UseItemLikeInCombatScene"

func _run():
	if(state == ""):
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(sceneArgs[0])
		
		saynn("You're about to use "+item.getVisibleName())

		addButton("Do it", "Use the item", "use")
		addButton("Cancel", "Don't use the item", "endthescene")
	if(state == "afteruse"):
		saynn(savedText)
		
		addButton("Continue", "You did it", "endthescene")


func _react(_action: String, _args):
	if(_action == "use"):
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(sceneArgs[0])
		savedText = item.useInCombat(GM.pc, GM.pc)
		setState("afteruse")
		return
		
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func _react_scene_end(_tag, _result):
	setState("")

func saveData():
	var data = .saveData()
	
	data["savedText"] = savedText
	
	return data
	
func loadData(data):
	.loadData(data)
	
	savedText = SAVE.loadVar(data, "savedText", "")