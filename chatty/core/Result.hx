
package chatty.core;

enum Result {
    WinGame;
    LoseGame;
    SetVariable(variable: Variable, value: Int);
}

