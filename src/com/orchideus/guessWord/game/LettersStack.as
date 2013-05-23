/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 15:22
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.events.EventDispatcher;

public class LettersStack extends EventDispatcher {

    public static const UPDATE: String = "update_LettersStack";
    public static const SELECT_LETTER: String = "select_letter_LettersStack";

    private var _letters: Array;
    public function get letters():Array {
        return _letters;
    }

    public function LettersStack() {
    }

    public function init(letters: Array):void {
        _letters = letters;
        update();
    }

    public function selectLetter(id: int):void {
        dispatchEventWith(SELECT_LETTER, false, _letters[id]);
        _letters[id] = null;
        update();
    }

    public function addLetter(letter: String):void {
        var i: int = 0;
        while (true) {
            if (!_letters[i]) {
                _letters[i] = letter;
                break;
            }
            i++;
        }
        update();
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }
}
}
