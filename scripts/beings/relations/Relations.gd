class_name Relations;

var relations: Array[Relation] = [];

func AddRelation(_relation: Relation):
    relations.append(_relation);

func GetFamily() -> Array[Relation]:
    var allFamily = relations.filter(func(x): return x.type == Relation.Type.parent || x.type == Relation.Type.sibling || x.type == Relation.Type.child || x.type == Relation.Type.grandparent || x.type == Relation.Type.grandchild)
    return allFamily;

func GetLovers() -> Array[Relation]:
    var allLovers = relations.filer(func(x); return x.type == Relation.Type.lover);
    return allLovers;