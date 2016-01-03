
package chatty.js;

import chatty.core.*;
import js.*;
import js.html.*;

class Main {
    static var menubar:Menu;

    static function get_color_name_value(name:String) {
        var test_div = Browser.document.createElement("div");
        test_div.style.color = name;
        Browser.document.body.appendChild(test_div);
        var result = Browser.window.getComputedStyle(test_div).color;
        Browser.document.body.removeChild(test_div);
        return result;
    }

    static function add_background_css() {
        var style:StyleElement = cast (Browser.document.getElementById("stylesheet"), StyleElement);

        var sheet = cast (style.sheet, CSSStyleSheet);

        var default_background:String;

        if (get_color_name_value("-moz-default-color") != get_color_name_value("-moz-default-background-color"))
        {
            /* Yay, Gecko extension for default background color is supported! */
            default_background = "-moz-default-background-color";
        }
        else
        {
            /* fake it */
            default_background = "white";
        }

        sheet.insertRule(".submenu { background-color: "+default_background+"; }", 0);
    }

    static function main() {
        trace("test");
        
        add_background_css();
        
        menubar = new Menu("menubar");
    }
}

