
package chatty.core;

// Represents a single variable (inventory item, solved puzzle, etc.)
class Variable extends Question {
    var first_bit : Int;
    var num_bits : Int;

    var mask : IntSet;
    var initial_state : IntSet;
}

