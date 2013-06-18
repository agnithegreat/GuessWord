/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 21:23
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import flash.net.SharedObject;

import starling.display.Stage;
import starling.events.Event;
import starling.utils.AssetManager;

public class Sound {

    public static var sounds: Array = [BTN_OVER, CLICK, SMALL_PIC, BIG_PIC, CHANGE_PIC, OPEN_LETTER, REMOVE_LETTERS, BACKSPACE, BETTER_SCORE, WIN, LOSE];

    public static const SOUND: String = "sound_Sound";

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
        _data.flush();
    }
    public static function get enabled():Boolean {
        return _data.data.sound;
    }

    private static var _assets: AssetManager;

    public static function init(assets: AssetManager):void {
        _data = SharedObject.getLocal("data");
        _assets = assets;
    }

    public static function listen(stage: Stage):void {
        stage.addEventListener(SOUND, handlePlaySound);
    }

    private static function handlePlaySound(event: Event):void {
        play(event.data as String);
    }

    public static function play(sound: String):void {
        if (enabled) {
            _assets.playSound(sound);
        }
    }
}
}
