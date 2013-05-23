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
    public static const CHECK_WORD: String = "check_word";
    public static const REMOVE_LETTERS: String = "remove_letters";
    public static const OPEN_LETTER: String = "open_letter";
    public static const CHANGE_PICTURE: String = "change_picture";
    public static const REMOVE_WRONG_PICTURE: String = "remove_wrong_picture";

    private static var auth_key: String;
    private static var sn_id: String;

    private var _url: String = "http://37.200.65.66/controller.php";
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
        sn_id = id;
    }

    public function getParameters():void {
        sendRequest(GET_PARAMETERS);
    }

    public function checkWord(word_id: int, word: String):void {
        sendRequest(CHECK_WORD, {"word_id": String(word_id), "word": word});
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

    private function sendRequest(method: String, data: Object = null):void {
        var requestVars:URLVariables = new URLVariables();
        requestVars.method = method;
        requestVars.auth_key = auth_key;

        if (!data) {
            data = {};
        }
        data.vk_id = sn_id;
        requestVars.data = JSON.stringify(data);
        trace(requestVars.data);

        var request:URLRequest = new URLRequest(_url);
        request.method = URLRequestMethod.GET;
        request.data = requestVars;

        processRequest(request);
    }

    private function processRequest(request: URLRequest):void {
        if (_stack.length>0) {
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
