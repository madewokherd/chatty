package chatty.js;

import js.*;
import js.html.*;

using chatty.js.JsExtender;

class MenuItem {
    public var div : DivElement;
    public var submenu : Menu;

    public function new(div:DivElement) {
        this.div = div;

        for (node in div.children) {
            if (node.nodeType == Node.ELEMENT_NODE)
            {
                var element = cast (node, Element);
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
}

