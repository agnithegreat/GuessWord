/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {

public class Game {

    private var _current_word_id: int;
    private var _current_symbols: String;
    private var _current_word_length: int;
    private var _changed_pic: int;
    private var _removed_symboles: int;
    private var _current_word_start: int;
    private var _current_wrong_pic_url: String;
    private var _current_wrong_pic_id: int;

    private var _letters: Array;
    private var _availableLetters: Array;

    public function Game() {
    }

    public function init(data: Object):void {
        _current_word_id = data.current_word_id;
        _current_symbols = data.current_symbols;
    }
}
}
