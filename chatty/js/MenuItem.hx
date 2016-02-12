package chatty.js;

import js.*;
import js.html.*;

using chatty.js.JsExtender;
using StringTools;

class MenuItem {
    public var div : DivElement;
    public var submenu : Menu;

    public var text(get, never) : String;

    public function new(div:DivElement) {
        this.div = div;

        for (node in div.children) {
            if (node.nodeType == Node.ELEMENT_NODE)
            {
                var element:Element = cast node;
                if (element.classList.contains("submenu")) {
                    trace(element.id);
                    this.submenu = new Menu(element.id, true);
                    element.set_aria_hidden(true);
                    div.set_aria_haspopup(true);
                    break;
                }
            }
        }
    }

    public function get_text() : String {
        for (node in div.childNodes) {
            if (node.nodeType == 3) {
                /* Text */
                var text = node.textContent.trim();
                if (text != "")
                    return text;
            }
        }
        return "";
    }
}

