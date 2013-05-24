/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:58
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.core.Starling;
import starling.events.EventDispatcher;

public class Word extends EventDispatcher {

    public static const UPDATE: String = "update_Word";
    public static const FULL: String = "full_Word";
    public static const ERROR: String = "error_Word";
    public static const DELETE_LETTER: String = "delete_letter_Word";

    public static const MAX_LETTERS: int = 15;

    private var _word_id: int;
    public function get word_id():int {
        return _word_id;
    }

    private var _letters: Vector.<Letter>;
    public function get letters():Vector.<Letter> {
        return _letters;
    }
    public function get word():String {
        var wd: String = "";
        for (var i:int = 0; i < _letters.length; i++) {
            if (_letters[i].letter) {
                wd += _letters[i].letter;
            }
        }
        return wd;
    }

    private var _filled: int;

    private var _length: int;
    public function get length():int {
        return _length;
    }

    public function Word() {
        _letters = new <Letter>[];
        for (var i:int = 0; i < MAX_LETTERS; i++) {
            _letters[i] = new Letter();
        }
    }

    public function init(word_id: int, length: int):void {
        _word_id = word_id;
        _length = length;
        _filled = 0;
        update();
    }

    public function setLetter(value: String):void {
        _letters[_filled].letter = value;
        update();

        while (_letters[_filled].letter) {
            _filled++;
        }

        if (_filled >= _length) {
            dispatchEventWith(FULL);
        }
    }

    public function deleteLetter(id: int):void {
        if (_letters[id].letter) {
            dispatchEventWith(DELETE_LETTER, false, _letters[id].letter);
            _letters[id].letter = null;
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
        dispatchEventWith(ERROR);

        Starling.juggler.delayCall(clear, 2);
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }
}
}
