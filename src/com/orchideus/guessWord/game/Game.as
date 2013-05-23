/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.events.Event;
import starling.events.EventDispatcher;

public class Game extends EventDispatcher {

    public static const INIT: String = "init_Game";
    public static const SEND_WORD: String = "send_word_Game";

    private var _word: Word;
    public function get word():Word {
        return _word;
    }

    private var _current_symbols: String;
    public function get current_symbols():String {
        return _current_symbols;
    }

    private var _changed_pic: int;
    private var _removed_symboles: int;
    private var _current_word_start: int;
    private var _current_wrong_pic_url: String;
    private var _current_wrong_pic_id: int;

    private var _pic1: String;
    public function get pic1(): String {
        return _pic1;
    }
    private var _pic2: String;
    public function get pic2(): String {
        return _pic2;
    }
    private var _pic3: String;
    public function get pic3(): String {
        return _pic3;
    }
    private var _pic4: String;
    public function get pic4(): String {
        return _pic4;
    }

    private var _letters: Array;
    private var _availableLetters: Array;

    public function Game() {
        _word = new Word();
        _word.addEventListener(Word.FULL, handleWordFull);
    }

    public function initWord(data: Object):void {
        _word.init(data.id, data.word_length);

        _current_word_start = data.current_word_start;
        _current_wrong_pic_url = data.current_wrong_pic_url;
        _current_wrong_pic_id = data.current_wrong_pic_id;

        _pic1 = data.pic1;
        _pic2 = data.pic2;
        _pic3 = data.pic3;
        _pic4 = data.pic4;

        dispatchEventWith(INIT);
    }

    private function handleWordFull(event: Event):void {
        dispatchEventWith(SEND_WORD);
    }
}
}
