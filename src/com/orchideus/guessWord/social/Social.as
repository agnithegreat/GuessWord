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
    public static const CHALLENGE: String = "challenge_Social";

    public static const LOGGED_IN: String = "logged_in_Social";
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

    public function init():void {
        if (Facebook.isSupported) {
            _facebook = Facebook.getInstance();
            _facebook.init(appID);
        }
    }

    public function login():void {
        if (isInitiated) {
            _facebook.openSessionWithPermissions(permissions, handleOpenSession);
        }
    }

    public function getFriends():void {
        if (session) {
            _facebook.requestWithGraphPath("/me/friends", null, "GET", handleGetFriends);
        }
    }

    public function invite():void {
        if (session) {
            // TODO: message
            _facebook.dialog("apprequests", {message: "Invite to Guess Word"});
        } else {
            login();
        }
    }

    public function post():void {
        if (session) {
            // TODO: url, messages
            _facebook.dialog("feed", {picture: "http://fbrell.com/f8.jpg", name: 'Facebook Dialogs', caption: 'Reference Documentation', description: 'Using Dialogs to interact with people.'});
        }
    }

    private function handleOpenSession(success: Boolean, userCancelled: Boolean, error: String = null):void {
        if (success) {
            dispatchEventWith(LOGGED_IN);
        }
    }

    private function handleGetFriends(data: Object):void {
        dispatchEventWith(GET_FRIENDS, false, data);
    }
}
}
