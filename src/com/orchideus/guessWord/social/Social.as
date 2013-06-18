/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 1:34
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.social {
import com.facebook.graph.Facebook;
import com.facebook.graph.data.FacebookAuthResponse;

import flash.system.Security;

import starling.events.EventDispatcher;

public class Social extends EventDispatcher {

    public static const INVITE: String = "invite_Social";
    public static const ASK: String = "ask_Social";

    public static const LOGGED_IN: String = "logged_in_Social";
    public static const GET_FRIENDS: String = "get_friends_Social";

    public static var appID: String = "205742966216110";
    public static var appSecret: String = "674e74cea065e1a166f47cbe623521d4";
    public static var permissions: Array = ["user_about_me", "offline_access", "publish_stream", "read_friendlists"];

    private var _apiSecuredPath:String = "https://graph.facebook.com";
    private var _apiUnsecuredPath:String = "http://graph.facebook.com";
    private var _userAuth : Boolean = false;

    private var _session: FacebookAuthResponse;
    public function get session():Boolean {
        return Boolean(_session);
    }

    public function get uid():String {
        return _session ? _session.uid : null;
    }

    public function init():void {
        Security.loadPolicyFile(_apiSecuredPath + "/crossdomain.xml");
        Security.loadPolicyFile(_apiUnsecuredPath + "/crossdomain.xml");
        Facebook.init(appID, handleInit, {cookie: true, "appId":appID,
            perms: permissions.toString()});
    }

    private function handleInit(success: Object, fail: Object):void {
        if (success) {
            Facebook.login(handleLogin, {scope: permissions.toString()});
        }
    }

    public function getFriends():void {
        Facebook.api("/me/friends", handleGetFriends, {fields: "installed"}, "GET");
    }

    public function invite(message: String):void {
        Facebook.ui("apprequest", {"message": message});
    }

    public function post(url: String, name: String, caption: String, description: String, to: String = null):void {
        Facebook.ui("stream.publish", {"to": to, "picture": url, "name": name, "caption": caption, "description": description});
    }

    private function handleLogin(success: Object, fail: Object):void {
        if (success) {
            _session = success as FacebookAuthResponse;
            dispatchEventWith(LOGGED_IN);
        }
    }

    private function handleGetFriends(success: Object, fail: Object):void {
        dispatchEventWith(GET_FRIENDS, false, success);
    }
}
}
