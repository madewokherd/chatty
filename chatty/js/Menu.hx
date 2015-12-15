
package chatty.js;

import js.*;
import js.html.*;

using chatty.js.JsExtender;

class Menu {
    var is_menubar : Bool;
    var menu_div : DivElement;

    public function new(id:String) {
        menu_div = cast(Browser.document.getElementById(id), DivElement);

        is_menubar = menu_div.classList.contains("menubar");
        trace("is_menubar=",is_menubar);
    }
}

