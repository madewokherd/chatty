
package chatty.core;

// Represents all the rules/state/hints for a single game
class World {
    // Variables, representing inventory items and such
    var variables : haxe.ds.StringMap<Variable>;

    // Actions the player can initiate, which change the state
    var actions : haxe.ds.StringMap<Action>;
    var actions_by_requirement : haxe.ds.ObjectMap<Variable, Action>;
    var actions_by_effect : haxe.ds.ObjectMap<Variable, Action>;

    // Events that change the state automatically
    var events : haxe.ds.StringMap<Action>;
    var events_by_requirement : haxe.ds.ObjectMap<Variable, Action>;
    var events_by_effect : haxe.ds.ObjectMap<Variable, Action>;

    // Questions that help deduce the state
    var questions : haxe.ds.Vector<Question>;
    var questions_by_requirement : haxe.ds.Vector<List<Question>>;

    // Hints
    var hints : haxe.ds.Vector<Hint>;
    var hints_by_requirement : haxe.ds.Vector<List<Hint>>;
}

