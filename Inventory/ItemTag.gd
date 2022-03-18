extends Object
class_name ItemTag

enum {
	Illegal,
	BDSMRestraint,
}

static func getName(tag):
	if(tag == Illegal):
		return "Illegal"
	if(tag == BDSMRestraint):
		return "Restraint"
	return "error"