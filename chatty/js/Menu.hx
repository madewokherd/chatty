
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

    public function new(id:String, is_submenu:Bool = false) {
        menu_div = cast(Browser.document.getElementById(id), DivElement);
        this.is_submenu = is_submenu;

        is_menubar = menu_div.classList.contains("menubar");

        this.items = new Array<MenuItem>();
        for (node in menu_div.children) {
            if (node.nodeType == Node.ELEMENT_NODE)
            {
                var element = cast (node, Element);
                if (element.has_role("menuitem")) {
                    this.items.push(new MenuItem(cast (node, DivElement)));
                }
            }
        }

        if (this.items.length != 0) {
            set_active_item(this.items[0]);
        }

        if (!is_submenu) {
            menu_div.addEventListener("keypress", this.on_keypress);
            menu_div.addEventListener("focus", this.on_focus, true);
            menu_div.addEventListener("blur", this.on_blur, true);
        }
    }

    public function select_prev_item() {
        var index = 0;
        while (index < items.length-1) {
            if (this.items[index] == active_item)
                break;
            index++;
        }
        if (index == 0) {
            set_active_item(items[items.length-1]);
        }
        else {
            set_active_item(items[index-1]);
        }
    }

    private function on_keypress(e:KeyboardEvent) {
        if (e.altKey) { }
        else if (e.ctrlKey) { }
        else if (e.metaKey) { }
        else if (e.shiftKey) { }
        else {
            switch (e.keyCode) {
                case 37: /* DOM_VK_LEFT */ {
                    if (is_menubar) {
                        select_prev_item();
                    }
                }
            }
        }
    }

    private function on_focus(e:Event) {
        has_focus = true;
    }

    private function on_blur(e:Event) {
        if (Browser.document.activeElement == null || !menu_div.contains(Browser.document.activeElement))
        {
            has_focus = false;
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

