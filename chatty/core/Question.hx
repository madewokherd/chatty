
package chatty.core;

class Question {
    var name : String; // a short description

    var question : String; // the actual question we will ask

    var is_boolean : Bool; // if True, this is a yes or no question

    var question_condition : Condition; // When to ask this question

    // For non-boolean questions:
    var answers : haxe.ds.Vector<String>;
    var answer_conditions : haxe.ds.Vector<Condition>;
}

