/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 10:59
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Word;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class WordView extends Sprite {

    public static const TILE: int = 56;

    private var _word: Word;

    private var _assets: AssetManager;

    private var _slots: Vector.<SlotTile>;
    private var _letters: Vector.<LetterTile>;
    private var _container: Sprite;

    public function WordView(word: Word, assets: AssetManager) {
        _word = word;
        _word.addEventListener(Word.UPDATE, handleUpdate);
        _word.addEventListener(Word.ERROR, handleError);

        _assets = assets;

        _container = new Sprite();
        addChild(_container);

        _slots = new <SlotTile>[];
        for (var i:int = 0; i < _word.letters.length; i++) {
            _slots[i] = new SlotTile(_assets);
            _slots[i].x = i*TILE;
        }

        _letters = new <LetterTile>[];
    }

    private function handleTouch(event: TouchEvent):void {
        var letter: LetterTile = event.currentTarget as LetterTile;
        var touch: Touch = event.getTouch(letter, TouchPhase.ENDED);
        if (touch && letter.letter.letter) {
            var index: int = _letters.indexOf(letter);
            _word.deleteLetter(index);
        }
    }

    private function handleUpdate(event:Event):void {
        _container.removeChildren();

        for (var i:int = 0; i < _slots.length; i++) {
            if (i < _word.length) {
                _container.addChild(_slots[i]);
            }
        }

        pivotX = width/2;
    }

    private function handleError(event:Event):void {
        _container.removeChildren();

        Sound.play(Sound.LOSE);

        pivotX = width/2;
    }
}
}
