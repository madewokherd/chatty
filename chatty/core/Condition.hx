
package chatty.core;

enum Condition {
    Always;
    Never;
    VariableEquals(variable: Variable, value: Int);
    ActionCompleted(solved: Bool, action: Action);
    All(conditions: haxe.ds.Vector<Condition>);
    Any(conditions: haxe.ds.Vector<Condition>);
    None(conditions: haxe.ds.Vector<Condition>);
    VariableCanChange(variable: Variable); // Only valid for questions generated from variables
}

