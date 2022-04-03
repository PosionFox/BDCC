extends Reference
class_name FluidProduction

var bodypart: WeakRef = null
var fluidAmount = 0.0

func getCapacity() -> float:
	return round(1000.0)

func getFluidAmount() -> float:
	return fluidAmount

func drain() -> float:
	var result = fluidAmount
	fluidAmount = 0
	return result

func afterMilked():
	pass

func getProductionSpeedPerHour() -> float:
	return getCapacity() / 10.0
	
func getFluidType():
	return BodilyFluids.FluidType.Milk

func shouldProduce():
	return true

func processTime(seconds: int):
	if(!shouldProduce()):
		return
	
	var minutesPassed: float = seconds / 60.0
	var hoursPassed: float = minutesPassed / 60.0

	fluidAmount += getProductionSpeedPerHour() * hoursPassed
	var maxCapacity = getCapacity()
	if(fluidAmount > maxCapacity):
		fluidAmount = maxCapacity

func getBodypart():
	return bodypart.get_ref()

func saveData():
	var data = {
		"fluidAmount": fluidAmount,
	}
	
	return data

func loadData(data):
	fluidAmount = SAVE.loadVar(data, "fluidAmount", 0.0)

func getAttributesText():
	return [
		["Producing", BodilyFluids.FluidType.getName(getFluidType())],
		["Capacity", str(round(getFluidAmount() * 10.0)/10.0)+"/"+ str(round(getCapacity() * 10.0)/10.0)+" ml"],		
		["Production speed", str(round(getProductionSpeedPerHour() * 10.0)/10.0)+" ml/hour"],
		["Currently producing", str(shouldProduce())],
	]
