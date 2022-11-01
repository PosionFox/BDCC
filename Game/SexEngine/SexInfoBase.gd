extends Reference
class_name SexInfoBase

var charID = null
var arousal: float = 0.0
var timesCame: int = 0

func initInfo(theCharID):
	charID = theCharID
	initFromPersonality()
	
func getChar() -> BaseCharacter:
	if(charID == null):
		return null
	
	return GlobalRegistry.getCharacter(charID)

func getInfoString():
	return ""

func initFromPersonality():
	pass

func processTurn():
	pass

func addArousal(howmuch: float):
	arousal += howmuch
	arousal = clamp(arousal, 0.0, 1.0)

func arousalNaturalFade():
	addArousal(-0.01)

func addArousalForeplay(howmuch: float):
	#var lustLevel = getChar().getLustLevel()
	# should be less efficient at high lust. or not
	if(arousal < 0.5):
		addArousal(howmuch)

func addArousalSex(howmuch: float):
	var lustLevel = getChar().getLustLevel()
	if(lustLevel < 0.4):
		# should be less efficient at low lust
		addArousal(howmuch * max(lustLevel, 0.1))
	else:
		addArousal(howmuch)

func getArousal() -> float:
	return arousal

func isCloseToCumming() -> bool:
	return arousal >= 0.7

func isReadyToCum() -> bool:
	return arousal >= 1.0
	
func cum():
	arousal = 0.0
	timesCame += 1

func getTimesCame():
	return timesCame

func isReadyToPenetrate() -> bool:
	return getChar().getLustLevel() >= 0.5

func fetishScore(fetishes = {}):
	var fetishHolder: FetishHolder = getChar().getFetishHolder()
	
	var result = 0.0
	for fetishID in fetishes:
		var fetishValue = fetishHolder.getFetishValue(fetishID)
		result += fetishValue * fetishes[fetishID]
	
	return result

func personalityScore(personalityStats = {}):
	var personality: Personality = getChar().getPersonality()
	
	var result = 0.0
	for personalityStatID in personalityStats:
		var personalityValue = personality.getStat(personalityStatID)
		result += personalityValue * personalityStats[personalityStatID]
	
	return result
