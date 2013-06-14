/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:24
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.events.EventDispatcher;
import starling.textures.Texture;

public class Friend extends EventDispatcher {

    public static const PHOTO: String = "photo_Friend";

    public static var FRIENDS: Object = {};
    public static var APP_FRIENDS: Array = [];

    public static function get uids():String {
        var ids: Array = [];
        for each (var o: Friend in FRIENDS) {
            if (o.installed) {
                ids.push(o.uid);
            }
        }
        return ids.join(",");
    }

    public static function get bestResult():int {
        return APP_FRIENDS.length>0 ? APP_FRIENDS[0].level : 0;
    }

    public static function getAnySucceed(level: int):Friend {
        return APP_FRIENDS.length>0 && APP_FRIENDS[0].level>=level ? APP_FRIENDS[0] : null;
    }

    public static function parseFriends(data: Object):void {
        var len: int = data.data.length;
        for (var i:int = 0; i < len; i++) {
            var fr: Object = data.data[i];
            var friend: Friend = FRIENDS[fr.id] ? FRIENDS[fr.id] : new Friend();
            friend.parseSocial(fr);
            FRIENDS[fr.id] = friend;
        }
    }

    public static function parseAppFriends(data: Object):void {
        for each (var fr: Object in data) {
            if (!FRIENDS[fr.vk_id]) {
                FRIENDS[fr.vk_id] = new Friend();
            }
            FRIENDS[fr.vk_id].parse(fr);
            APP_FRIENDS.push(FRIENDS[fr.vk_id]);
        }
        APP_FRIENDS.sortOn("level", Array.NUMERIC+Array.DESCENDING);
    }
    
    private var _uid: String;
    public function get uid():String {
        return _uid;
    }

    private var _level: int;
    public function get level():int {
        return _level;
    }

    private var _url: String;
    public function set url(value: String):void {
        _url = value;
    }

    private var _loader: Loader;

    private var _photo: Texture;
    public function get photo():Texture {
        return _photo;
    }

    private var _installed: Boolean;
    public function get installed():Boolean {
        return _installed;
    }

    public function parseSocial(data: Object):void {
        _uid = data.id;
        url = "https://graph.facebook.com/"+_uid+"/picture";
        _installed = data.installed;
    }

    public function parse(data: Object):void {
        _uid = data.vk_id;
        url = "https://graph.facebook.com/"+_uid+"/picture";
        _level = data.level;
    }

    public function load():void {
        if (_loader || !_url) {
            return;
        }

        _loader = new Loader();
        _loader.load(new URLRequest(_url));
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
    }

    private function onComplete(event: Event):void {
        _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);

        var loadedBitmap: Bitmap = _loader.content as Bitmap;
        var texture: Texture = Texture.fromBitmap(loadedBitmap);

        _photo = texture;

        dispatchEventWith(PHOTO);
    }
}
}
