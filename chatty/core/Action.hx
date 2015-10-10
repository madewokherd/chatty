
package chatty.core;

class Action extends Variable {
    // Questions must be boolean, empty string, and asked never
    var action_condition : Condition; // When this action can be done
    var can_be_repeated : Bool; // True if this can be done more than once

    var results : haxe.ds.Vector<Result>; // What happens when this action is done?

    var is_event : Bool; // True if this happens without player intervention when the condition is met

    var hint_segments : haxe.ds.Vector<String>; // optional, hint to display when condition is met
}

