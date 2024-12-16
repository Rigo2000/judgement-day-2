class_name Relation;

var being: Being;
var type: Type;

enum Type {
    parent,
    child,
    sibling,
    grandparent,
    grandchild,
    friend,
    lover,
    enemy,
    acquaintance
}