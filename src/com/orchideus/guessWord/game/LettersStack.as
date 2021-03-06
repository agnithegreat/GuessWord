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

    private var _letters: Vector.<Letter>;
    public function get letters():Vector.<Letter> {
        return _letters;
    }

    public function LettersStack() {
        _letters = new <Letter>[];
        for (var i:int = 0; i < 20; i++) {
            _letters[i] = new Letter();
        }
    }

    public function init(letters: Array):void {
        for (var i:int = 0; i < _letters.length; i++) {
            _letters[i].setLetter(letters.length>i ? letters[i] : null, false);
        }
    }

    public function removeLetter(id: int):void {
        _letters[id].setLetter(null, true);
    }

    public function addLetter(letter: String):void {
        var i: int = 0;
        while (i<_letters.length) {
            if (!_letters[i].letter) {
                _letters[i].setLetter(letter, true);
                break;
            }
            i++;
        }
    }
}
}
