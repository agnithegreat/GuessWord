/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:58
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.events.EventDispatcher;

public class Word extends EventDispatcher {

    public static const UPDATE: String = "update_Word";
    public static const FULL: String = "full_Word";
    public static const ERROR: String = "error_Word";
    public static const DELETE_LETTER: String = "delete_letter_Word";

    private var _word_id: int;
    public function get word_id():int {
        return _word_id;
    }

    private var _letters: Array;
    public function get letters():Array {
        return _letters;
    }

    private var _filled: int;

    public function Word() {
    }

    public function init(word_id: int, length: int):void {
        _word_id = word_id;
        _letters = new Array(length);
        _filled = 0;
        update();
    }

    public function setLetter(value: String):void {
        _letters[_filled] = value;
        update();

        while (_letters[_filled]) {
            _filled++;
        }

        if (_filled>=_letters.length) {
            dispatchEventWith(FULL);
        }
    }

    public function deleteLetter(id: int):void {
        if (_letters[id]) {
            dispatchEventWith(DELETE_LETTER, false, _letters[id]);
            _letters[id] = null;
            _filled = Math.min(_filled, id);
        }
        update();
    }

    public function clear():void {
        for (var i:int = 0; i < _letters.length; i++) {
            deleteLetter(i);
        }
    }

    public function error():void {
        clear();
        dispatchEventWith(ERROR);
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }
}
}
