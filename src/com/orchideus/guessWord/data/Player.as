/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:22
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import com.laiyonghao.Uuid;

import flash.net.SharedObject;

import starling.events.EventDispatcher;

public class Player extends EventDispatcher {

    public static const UPDATE: String = "update_Player";

    private var _data: SharedObject;

    public function get uid():String {
        return _data.data.uid;
    }

    public function get level():int {
        return _data.data.level;
    }

    public function get money():int {
        return _data.data.money;
    }

    public function Player() {
        _data = SharedObject.getLocal("data");
        if (!_data.data.created) {
            setDefaultValues();
        }
    }

    private function setDefaultValues():void {
        _data.data.uid = (new Uuid()).toString();
        _data.data.sound = true;
        _data.data.created = true;
        _data.data.level = 1;
    }

    public function parse(data: Object):void {
        _data.data.level = data.level;
        _data.data.money = data.money;

        update();
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }
}
}
