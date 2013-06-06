/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 19:26
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.events.EventDispatcher;

public class Letter extends EventDispatcher {

    public static const UPDATE: String = "update_Letter";
    public static const MISTAKE: String = "mistake_Letter";

    private var _letter: String;
    public function get letter():String {
        return _letter;
    }

    private var _locked: Boolean;
    public function get locked():Boolean {
        return _locked;
    }
    public function set locked(value: Boolean):void {
        _locked = value;
    }

    public function Letter() {
    }

    public function setLetter(letter: String, animate: Boolean):void {
        _letter = letter;
        dispatchEventWith(UPDATE, false, animate);
    }

    public function mistake():void {
        dispatchEventWith(MISTAKE);
    }
}
}
