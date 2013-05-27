/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 21:23
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import flash.net.SharedObject;

import starling.utils.AssetManager;

public class Sound {

    public static const BTN_OVER: String = "Btn_over";
    public static const CLICK: String = "click";
    public static const SMALL_PIC: String = "Small_pic";
    public static const BIG_PIC: String = "Big_pic";
    public static const CHANGE_PIC: String = "Change_pic";
    public static const OPEN_LETTER: String = "Open_letter";
    public static const REMOVE_LETTERS: String = "Remove_letters";
    public static const BACKSPACE: String = "backspace";
    public static const BETTER_SCORE: String = "Better_score";
    public static const WIN: String = "Win";
    public static const LOSE: String = "Lose";

    private static var _data: SharedObject;
    public static function set enabled(value: Boolean):void {
        _data.data.sound = value;
    }
    public static function get enabled():Boolean {
        return _data.data.sound;
    }

    private static var _assets: AssetManager;

    public static function init(assets: AssetManager):void {
        _data = SharedObject.getLocal("data");
        _assets = assets;
    }


    public static function play(name: String):void {
        if (enabled) {
            _assets.playSound(name);
        }
    }
}
}
