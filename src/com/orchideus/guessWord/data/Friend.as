/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:24
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Friend {
    
    public static var FRIENDS: Object = {};
    
    public static function parse(data: Object):void {
        for each (var fr: Object in data) {
            if (!FRIENDS[fr.vk_id]) {
                FRIENDS[fr.vk_id] = new Friend();
            }
            FRIENDS[fr.vk_id].parse(fr);
        }
    }
    
    private var _uid: String;
    public function get uid():String {
        return _uid;
    }

    private var _level: int;
    public function get level():int {
        return _level;
    }

    public function parse(data: Object):void {
        _uid = data.vk_id;
        _level = data.level;
    }
}
}
