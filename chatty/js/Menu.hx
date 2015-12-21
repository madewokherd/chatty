
package chatty.js;

import js.*;
import js.html.*;

using chatty.js.JsExtender;

class Menu {
    var is_menubar : Bool;
    var menu_div : DivElement;
    var items : Array<MenuItem>;

    public function new(id:String) {
        menu_div = cast(Browser.document.getElementById(id), DivElement);

        is_menubar = menu_div.classList.contains("menubar");

        this.items = new Array<MenuItem>();
        for (node in menu_div.children) {
            if (node.nodeType == Node.ELEMENT_NODE)
            {
                var element = cast (node, Element);
                if (element.has_role("menuitem")) {
                    this.items.push(new MenuItem(cast (node, DivElement)));
                    trace(element.id);
                }
            }
        }
    }
}

