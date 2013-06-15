/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:13
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.server {
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

import starling.events.EventDispatcher;

public class Server extends EventDispatcher {

    public static const DATA: String = "data_Server";

    public static const GET_PARAMETERS: String = "get_parameters";
    public static const GET_MONEY: String = "get_money";
    public static const CHECK_WORD: String = "check_word";
    public static const START_TIMER: String = "start_timer";
    public static const REMOVE_LETTERS: String = "remove_letters";
    public static const OPEN_LETTER: String = "open_letter";
    public static const CHANGE_PICTURE: String = "change_picture";
    public static const REMOVE_WRONG_PICTURE: String = "remove_wrong_picture";
    public static const GET_FRIEND_BAR: String = "get_friend_bar";
    public static const GET_FRIENDS_WORDS: String = "get_friends_words";

    private static var auth_key: String;
    private static var uid: String;

    private var _url: String = "http://46.72.211.10:82/";
    public function get url():String {
        return _url;
    }

    private var _controllerURL: String = _url+"controller_ios.php";

    private var _loader: URLLoader;

    private var _stack: Vector.<URLRequest>;
    private var _currentRequest: URLRequest;

    public function Server() {
        _loader = new URLLoader();
        _loader.dataFormat = URLLoaderDataFormat.TEXT;
        _loader.addEventListener(Event.COMPLETE, handleComplete);
        _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
        _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        _loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

        _stack = new <URLRequest>[];
    }

    public function init(key: String, id: String):void {
        auth_key = key;
        uid = id;
    }

    public function getParameters():void {
        sendRequest(GET_PARAMETERS);
    }

    public function getMoney():void {
        sendRequest(GET_MONEY);
    }

    public function checkWord(word_id: int, word: String):void {
        sendRequest(CHECK_WORD, {"word_id": String(word_id), "word": word});
    }

    public function startTimer():void {
        sendRequest(START_TIMER);
    }

    public function removeLetters():void {
        sendRequest(REMOVE_LETTERS);
    }

    public function openLetter():void {
        sendRequest(OPEN_LETTER);
    }

    public function changePicture(pic_id: int):void {
        sendRequest(CHANGE_PICTURE, {"pic_id": pic_id});
    }

    public function removeWrongPicture():void {
        sendRequest(REMOVE_WRONG_PICTURE);
    }

    public function getFriendBar(uid: String, ids: String):void {
        sendRequest(GET_FRIEND_BAR, {"fb_id": uid, "ids": ids});
    }

    public function getFriendsWords(ids: Array, word_id: int):void {
        sendRequest(GET_FRIENDS_WORDS, {"ids": ids.join(","), "word_id": word_id});
    }

    private function sendRequest(method: String, data: Object = null):void {
        var requestVars:URLVariables = new URLVariables();
        requestVars.method = method;
        requestVars.auth_key = auth_key;

        if (!data) {
            data = {};
        }
        data.ios_id = uid;
        data.network = "0";
        data.game_type = "1";
        requestVars.data = JSON.stringify(data);

        var request:URLRequest = new URLRequest(_controllerURL);
        request.method = URLRequestMethod.GET;
        request.data = requestVars;

        trace(request.url+"?"+request.data);

        processRequest(request);
    }

    private function processRequest(request: URLRequest):void {
        if (_currentRequest) {
            _stack.push(request);
        } else {
            _currentRequest = request;
            _loader.load(_currentRequest);
        }
}

    private function handleComplete(event:Event):void {
        trace(_loader.data);

        var data: Object = JSON.parse(_loader.data);

        data.method = _currentRequest.data.method;
        _currentRequest = null;

        dispatchEventWith(DATA, false, data);


        if (_stack.length>0) {
            processRequest(_stack.pop());
        }
    }

    private function ioErrorHandler(event:IOErrorEvent):void {

    }

    private function securityErrorHandler(event:SecurityErrorEvent):void {

    }

    private function httpStatusHandler(event:HTTPStatusEvent):void {

    }
}
}
