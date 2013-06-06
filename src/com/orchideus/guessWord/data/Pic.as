/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import starling.events.EventDispatcher;

public class Pic extends EventDispatcher {

    public static const UPDATE: String = "update_Pic";

    private var _url: String;
    public function get url():String {
        return _url;
    }
    public function set url(value:String):void {
        _url = value;
        update();
    }

    private var _description: String;
    public function get description():String {
        return _description;
    }
    public function set description(value:String):void {
        _description = value;
        update();
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }
}
}
