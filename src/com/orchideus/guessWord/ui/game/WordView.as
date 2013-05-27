/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 10:59
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.game.Word;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Image;
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

    private var _letters: Vector.<LetterTile>;
    private var _container: Sprite;

//    private var _error: Image;

    public function WordView(word: Word, assets: AssetManager) {
        _word = word;
        _word.addEventListener(Word.UPDATE, handleUpdate);
        _word.addEventListener(Word.ERROR, handleError);

        _assets = assets;

        _container = new Sprite();
        addChild(_container);

//        _error = new Image(assets.getTexture("error"));

        _letters = new <LetterTile>[];
        for (var i:int = 0; i < _word.letters.length; i++) {
            _letters[i] = new LetterTile(_word.letters[i], _assets);
            _letters[i].addEventListener(TouchEvent.TOUCH, handleTouch);
            _letters[i].x = i*TILE;
        }
    }

    private function handleTouch(event: TouchEvent):void {
        var letter: LetterTile = event.currentTarget as LetterTile;
        var touch: Touch = event.getTouch(letter, TouchPhase.ENDED);
        if (touch && letter.letter.letter) {
            var index: int = _letters.indexOf(letter);
            _word.deleteLetter(index);

            _assets.playSound("click");
        }
    }

    private function handleUpdate(event:Event):void {
        _container.removeChildren();

//        if (_error.parent) {
//            removeChild(_error);
//        }

        for (var i:int = 0; i < _letters.length; i++) {
            if (i < _word.length) {
                _container.addChild(_letters[i]);
            }
        }

        pivotX = width/2;
    }

    private function handleError(event:Event):void {
        _container.removeChildren();
//        addChild(_error);

        _assets.playSound("Lose");

        pivotX = width/2;
    }
}
}
