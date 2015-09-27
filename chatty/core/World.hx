
package chatty.core;

// Represents all the rules/state/hints for a single game
class World {

    // "flag" variables, representing inventory items and such
    var variable_names : haxe.ds.Vector<String>;
    var name_table : haxe.ds.StringMap<Int>;

    // var initial_state : State;

    // Actions the player can initiate, which change the state
    // var actions : haxe.ds.Vector<Action>;
    // var actions_by_requirement : haxe.ds.Vector<List<Action>>
    // var actions_by_effect : haxe.ds.Vector<List<Action>>

    // Events that change the state automatically
    // var events : haxe.ds.Vector<Action>;
    // var events_by_requirement : haxe.ds.Vector<List<Action>>
    // var events_by_effect : haxe.ds.Vector<List<Action>>

    // Questions that help deduce the state
    // var questions : haxe.ds.Vector<Question>;
    // var questions_by_requirement : haxe.ds.Vector<List<Question>>;

    // Hints
    // var hints : haxe.ds.Vector<Hint>;
    // var hints_by_requirement : haxe.ds.Vector<List<Hint>>;

}

