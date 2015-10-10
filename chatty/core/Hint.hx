
package chatty.core;

class Hint {
    var name : String; // a short description

    var condition : Condition; // When this hint should be displayed

    var is_important : Bool; // if True, the guide MUST display this hint if the condition is met

    var hint_segments : haxe.ds.Vector<String>; // hint to display when condition is met
}

