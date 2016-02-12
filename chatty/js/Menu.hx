
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
        menu_div = cast Browser.document.getElementById(id);
        this.is_submenu = is_submenu;

        is_menubar = menu_div.classList.contains("menubar");

        this.items = new Array<MenuItem>();
        for (node in menu_div.children) {
            if (node.nodeType == Node.ELEMENT_NODE)
            {
                var element:Element = cast node;
                if (element.has_role("menuitem")) {
                    this.items.push(new MenuItem(cast node));
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

    public function select_next_item() {
        var index = 0;
        while (index < items.length-1) {
            if (this.items[index] == active_item)
                break;
            index++;
        }
        if (index == items.length-1) {
            set_active_item(items[0]);
        }
        else {
            set_active_item(items[index+1]);
        }
    }

    private function get_open_menus():List<Menu> {
        var result = new List<Menu>();
        var parent = this;
        while (parent != null && !parent.menu_div.get_aria_hidden()) {
            result.push(parent);
            if (parent.active_item != null)
                parent = parent.active_item.submenu;
            else
                break;
        }
        return result;
    }

    public function get_active_item():MenuItem {
        var open_menus = get_open_menus();
        if (open_menus.first() == null)
            return null;
        if (open_menus.first().active_item == null) {
            open_menus.pop();
            if (open_menus.first() == null)
                return null;
        }
        var menu = open_menus.first();
        if (menu != null)
            return menu.active_item;
        return null;
    }

    public function expand_submenu(item:MenuItem, select_first:Bool) {
        if (item.submenu.menu_div.get_aria_hidden()) {
            var items = item.submenu.items;
            if (items.length != 0) {
                if (select_first)
                    item.submenu.set_active_item(items[0]);
                else
                    item.submenu.set_active_item(items[items.length-1]);
            }
            var submenu_div = item.submenu.menu_div;
            var item_div = item.div;
            if (item_div.classList.contains("menuitem"))
                submenu_div.setAttribute("style", "left: " + (item_div.offsetLeft + item_div.offsetWidth) + "px; top: "+item_div.offsetTop+"px;");
            else
                submenu_div.setAttribute("style", "left: "+item_div.offsetLeft+"px; top: " + (item_div.offsetTop + item_div.offsetHeight) + "px;");
            item.submenu.menu_div.set_aria_hidden(false);
        }
    }

    public function collapse_to(menu:Menu) {
        for (open_menu in get_open_menus()) {
            if (open_menu == menu)
                break;
            open_menu.menu_div.set_aria_hidden(true);
        }
    }

    public function collapse_all() {
        collapse_to(this);
    }

    public function invoke_item(item:MenuItem) {
        if (item.submenu != null) {
            if (item.submenu.menu_div.get_aria_hidden()) {
                expand_submenu(item, true);
            }
            /* else collapse_submenu */
        }
    }

    private function on_keypress(e:KeyboardEvent) {
        if (e.altKey) { }
        else if (e.ctrlKey) { }
        else if (e.metaKey) { }
        else if (e.shiftKey) { }
        else {
            var keyCode:Int = untyped(e.which || e.keyCode);
            switch (keyCode) {
                case 27: /* DOM_VK_ESCAPE */ {
                    collapse_all();
                }
                case 37: /* DOM_VK_LEFT */ {
                    var menus = get_open_menus();
                    var menu = menus.pop();
                    var parent = menus.pop();
                    if (menu != null) {
                        if (menu.is_menubar) {
                            menu.select_prev_item();
                        }
                        else if (parent != null) {
                            if (parent.is_menubar) {
                                parent.select_prev_item();
                                if (parent.active_item != null && parent.active_item.submenu != null)
                                    parent.expand_submenu(parent.active_item, true);
                            }
                            else {
                                collapse_to(parent);
                            }
                        }
                    }
                }
                case 38: /* DOM_VK_UP */ {
                    var menu = get_open_menus().first();
                    if (menu.is_menubar) {
                        if (menu.active_item != null && menu.active_item.submenu != null) {
                            menu.expand_submenu(menu.active_item, false);
                        }
                    }
                    else {
                        menu.select_prev_item();
                    }
                }
                case 39: /* DOM_VK_RIGHT */ {
                    var menu = get_open_menus().first();
                    if (!menu.is_menubar && menu.active_item != null && menu.active_item.submenu != null) {
                        menu.expand_submenu(menu.active_item, true);
                    }
                    else if (is_menubar) {
                        select_next_item();
                        if (menu != this && active_item != null && active_item.submenu != null)
                            expand_submenu(active_item, true);
                    }
                }
                case 40: /* DOM_VK_DOWN */ {
                    var menu = get_open_menus().first();
                    if (menu.is_menubar) {
                        if (menu.active_item != null && menu.active_item.submenu != null) {
                            menu.expand_submenu(menu.active_item, true);
                        }
                    }
                    else {
                        menu.select_next_item();
                    }
                }
                case 32 /* DOM_VK_SPACE */ | 13 /* DOM_VK_RETURN */: {
                    var item = get_active_item();
                    if (item != null) {
                        invoke_item(item);
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
        if (this.active_item == active_item)
            return;
        collapse_all();
        if (this.active_item != null) {
            this.active_item.div.classList.remove("active");
        }
        active_item.div.classList.add("active");
        this.active_item = active_item;
        for (item in items) {
            if (item == active_item) {
                if (is_submenu)
                    menu_div.set_aria_active_descendant(item.div.id);
                if (!is_submenu)
                    item.div.tabIndex = 0;
            }
            else {
                if (!is_submenu)
                    item.div.tabIndex = -1;
            }
        }
        if (has_focus && active_item != null) {
            active_item.div.focus();
        }
    }
}

