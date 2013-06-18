/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:22
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import flash.net.SharedObject;

import starling.events.EventDispatcher;

public class Player extends EventDispatcher {

    public static const UPDATE: String = "update_Player";

    private var _data: SharedObject;

    public function get uid():String {
        return _data.data.uid;
    }
    public function set uid(value: String):void {
        _data.data.uid = value;
        save();
    }

    public function get level():int {
        return _data.data.level;
    }

    public function get money():int {
        return _data.data.money;
    }

    public function get lang():String {
        return _data.data.language;
    }

    public function Player() {
        load();
    }

    public function parse(data: Object):void {
        if (data.hasOwnProperty("fb_id")) {
            _data.data.uid = data.fb_id;
        }
        if (data.hasOwnProperty("level")) {
            _data.data.level = data.level;
        }
        if (data.hasOwnProperty("money")) {
            _data.data.money = data.money;
        }
        save();

        update();
    }

    public function setLanguage(lang: String):void {
        _data.data.language = lang;
        save();
    }

    private function save():void {
        _data.flush();
    }

    private function load():void {
        _data = SharedObject.getLocal("data");
        if (!_data.data.created) {
            setDefaultValues();
            save();
        }
    }

    private function setDefaultValues():void {
        _data.data.sound = true;
        _data.data.created = true;
        _data.data.level = 1;
        _data.data.language = null;
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }
}
}
