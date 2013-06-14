/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 1:34
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.social {
import com.freshplanet.ane.AirFacebook.Facebook;

import starling.events.EventDispatcher;

public class Social extends EventDispatcher {

    public static const INVITE: String = "invite_Social";
    public static const ASK: String = "ask_Social";

    public static const LOGGED_IN: String = "logged_in_Social";
    public static const GET_ME: String = "get_me_Social";
    public static const GET_FRIENDS: String = "get_friends_Social";

    public static var appID: String = "205742966216110";
    public static var permissions: Array = ["user_about_me", "offline_access", "publish_stream", "read_friendlists"];

    private var _facebook: Facebook;
    public function get isInitiated():Boolean {
        return Boolean(_facebook);
    }
    public function get session():Boolean {
        return isInitiated && _facebook.isSessionOpen;
    }

    private var _me: Object;
    public function get uid():String {
        return _me.id;
    }

    public function init():void {
        if (Facebook.isSupported) {
            _facebook = Facebook.getInstance();
            _facebook.init(appID);

            if (session) {
                dispatchEventWith(LOGGED_IN);
            }
        }
    }

    public function login():void {
        if (isInitiated) {
            _facebook.openSessionWithPermissions(permissions, handleOpenSession);
        }
    }

    public function getMe():void {
        if (session) {
            _facebook.requestWithGraphPath("/me", null, "GET", handleGetMe);
        }
    }

    public function getFriends():void {
        if (session) {
            _facebook.requestWithGraphPath("/me/friends", {fields: "id,installed"}, "GET", handleGetFriends);
        }
    }

    public function invite(message: String):void {
        if (session) {
            _facebook.dialog("apprequests", {"message": message});
        } else {
            login();
        }
    }

    public function post(url: String, name: String, caption: String, description: String, to: String = null):void {
        if (session) {
            _facebook.dialog("feed", {"to": to, "picture": url, "name": name, "caption": caption, "description": description});
        }
    }

    private function handleOpenSession(success: Boolean, userCancelled: Boolean, error: String = null):void {
        if (success) {
            dispatchEventWith(LOGGED_IN);
        }
    }

    private function handleGetMe(data: Object):void {
        _me = data;
        dispatchEventWith(GET_ME);
    }

    private function handleGetFriends(data: Object):void {
        dispatchEventWith(GET_FRIENDS, false, data);
    }
}
}
