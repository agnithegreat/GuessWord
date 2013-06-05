/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.data.Player;

import starling.core.Starling;

import starling.events.Event;
import starling.events.EventDispatcher;

public class Game extends EventDispatcher {

    public static const INIT: String = "init_Game";
    public static const UPDATE: String = "update_Game";
    public static const RESET: String = "reset_Game";
    public static const SEND_WORD: String = "send_word_Game";
    public static const WIN: String = "win_Game";

    private var _word: Word;
    public function get word():Word {
        return _word;
    }

    private var _stack: LettersStack;
    public function get stack():LettersStack {
        return _stack;
    }

    private var _changed_pic: int;
    private var _current_wrong_pic_url: String;
    private var _current_wrong_pic_id: int;

    public var pic1: Pic;
    public var pic2: Pic;
    public var pic3: Pic;
    public var pic4: Pic;

    private var _letters: Array;
    private var _availableLetters: Array;

    public function Game() {
        _word = new Word();
        _word.addEventListener(Word.FULL, handleWordFull);

        pic1 = new Pic();
        pic2 = new Pic();
        pic3 = new Pic();
        pic4 = new Pic();

        _stack = new LettersStack();
    }

    public function initWord(data: Object):void {
        _word.init(data.id, data.word_length);

        updateWord(data);

        _current_wrong_pic_url = data.current_wrong_pic_url;
        _current_wrong_pic_id = data.current_wrong_pic_id;

        pic1.url = data.pic1;
        pic2.url = data.pic2;
        pic3.url = data.pic3;
        pic4.url = data.pic4;

        pic1.description = data.pic1_descr;
        pic2.description = data.pic2_descr;
        pic3.description = data.pic3_descr;
        pic4.description = data.pic4_descr;

        dispatchEventWith(INIT);
    }

    public function updateStack(data: Object):void {
        if (data.current_symbols) {
            _stack.init(data.current_symbols);
        }
    }

    public function updateWord(data: Object):void {

        var symLen: int = data.symbols ? data.symbols.length : 0;
        for (var i:int = 0; i < symLen; i++) {
            var symbol: Object = data.symbols[i];
            _word.openSymbol(symbol.position, symbol.symbol);
        }
    }

    public function updateDescription(data: Object):void {
        pic1.description = data.pic1_descr;
        pic2.description = data.pic2_descr;
        pic3.description = data.pic3_descr;
        pic4.description = data.pic4_descr;
    }

    public function selectLetter(id: int):void {
        trace(_word.isComplete);
        if (!_word.isComplete) {
            var letter: String = _stack.letters[id].letter;
            _stack.removeLetter(id);
            _word.setLetter(letter);
        }
    }

    public function removeLetter(id: int, force: Boolean = false):void {
        if (!_word.isComplete || force) {
            var letter: String = _word.letters[id].letter;
            if (_word.removeLetter(id, false)) {
                _stack.addLetter(letter);
            }
        }
    }

    public function win():void {
        dispatchEventWith(WIN);
    }

    public function wordError():void {
        _word.error();
        Starling.juggler.delayCall(reset, 1.5);
    }

    public function reset():void {
        for (var i:int = 0; i < _word.length; i++) {
            removeLetter(i, true);
        }
        dispatchEventWith(RESET);
    }

    private function update():void {
        dispatchEventWith(UPDATE);
    }

    private function handleWordFull(event: Event):void {
        dispatchEventWith(SEND_WORD);
    }
}
}
