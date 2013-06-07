/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:24
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Friend {

    public static const INVITE: String = "invite_Friend";
    
    public static var FRIENDS: Object = {};
    public static var FRIENDS_ARRAY: Array = [];

    public static function parse(data: Object):void {
        data = [{vk_id: "3602860", level: 11},{vk_id: "3602861", level: 10},{vk_id: "3602862", level: 9}];

        for each (var fr: Object in data) {
            if (!FRIENDS[fr.vk_id]) {
                FRIENDS[fr.vk_id] = new Friend();
            }
            FRIENDS[fr.vk_id].parse(fr);
            FRIENDS_ARRAY.push(FRIENDS[fr.vk_id]);

        }
        FRIENDS_ARRAY.sortOn("level", Array.NUMERIC+Array.DESCENDING);
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
