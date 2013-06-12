/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 9:50
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.localization {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.Dictionary;

public class LocalizationManager {

    private var _strings: Dictionary = new Dictionary();
    public function getString(id: String):String {
        return _strings[id];
    }

    private var _callback: Function;

    public function loadLocale(url: String, callback: Function):void {
        _callback = callback;

        var loader: URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, handleComplete);
        var request: URLRequest = new URLRequest(url);
        loader.load(request);
    }

    private function handleComplete(event: Event):void {
        var myData:String = (event.currentTarget as URLLoader).data;
        var myDataRows:Array = myData.split("\n");
        for (var i:int = 1; i < myDataRows.length; i++) {
            var smallArray: Array = myDataRows[i].split(",");
            _strings[smallArray[0]] = smallArray[1].replace("^", "\n").replace("^", "\n");
        }

        if (_callback is Function) {
            _callback();
        }
        _callback = null;
    }
}
}
