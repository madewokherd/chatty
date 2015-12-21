package chatty.js;

import js.*;
import js.html.*;

class JsExtender {
    static public function has_role(element:Element, name:String) {
        for (role in element.getAttribute("role").split(" ")) {
            if (role == name)
                return true;
        }
        return false;
    }
    static public inline function addEventListener(element:Element, event:String, f:Dynamic, useCapture:Bool = false):Void {
        untyped {
            untyped element.addEventListener(event, f, useCapture);
        }
    }
}

