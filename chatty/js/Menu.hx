
package chatty.js;

import js.*;
import js.html.*;

using chatty.js.JsExtender;

class Menu {
    var is_menubar : Bool;
    var menu_div : DivElement;
    var items : Array<MenuItem>;
    var has_focus : Bool;
    var active_item : MenuItem;
    var is_submenu : Bool;

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

        if (this.items.length != 0) {
            set_active_item(this.items[0]);
        }
    }

    public function set_active_item(active_item:MenuItem) {
        this.active_item = active_item;
        for (item in items) {
            if (item == active_item) {
                if (!is_submenu)
                    item.div.tabIndex = 0;
            }
            else {
                if (!is_submenu)
                    item.div.tabIndex = -1;
            }
        }
        if (has_focus) {
            active_item.div.focus();
        }
    }
}

