/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 19:26
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.events.EventDispatcher;

public class Letter extends EventDispatcher {

    public static const UPDATE: String = "update_Letter";
    public static const MISTAKE: String = "mistake_Letter";

    private var _letter: String;
    public function get letter():String {
        return _letter;
    }
    public function set letter(value: String):void {
        _letter = value;
        update();
    }

    public function Letter() {
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }

    public function mistake():void {
        dispatchEventWith(MISTAKE);
    }
}
}
