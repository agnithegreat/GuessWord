/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 15:12
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.game.LettersStack;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class LettersView extends Sprite {

    public static const TILE: int = 52;

    private var _stack: LettersStack;

    private var _assets: AssetManager;

    private var _letters: Vector.<LetterTile>;
    private var _container: Sprite;

    public function LettersView(stack: LettersStack, assets: AssetManager) {
        _stack = stack;
        _stack.addEventListener(LettersStack.UPDATE, handleUpdate);

        _assets = assets;

        _container = new Sprite();
        addChild(_container);

        _letters = new <LetterTile>[];
        for (var i:int = 0; i < 20; i++) {
            _letters[i] = new LetterTile(_assets.getTexture("empty_symbol"));
            _letters[i].addEventListener(TouchEvent.TOUCH, handleTouch);
            _letters[i].x = (i%10)*TILE;
            _letters[i].y = int(i/10)*TILE;
            _container.addChild(_letters[i]);
        }

        pivotX = width/2;
    }

    private function handleUpdate(event: Event):void {
        for (var i:int = 0; i < _letters.length; i++) {
            var letter: String = _stack.letters[i];
            if (letter) {
                _letters[i].visible = true;
                _letters[i].setLetter(letter);
            } else {
                _letters[i].visible = false;
            }
        }
    }

    private function handleTouch(event: TouchEvent):void {
        var letter: LetterTile = event.currentTarget as LetterTile;
        var touch: Touch = event.getTouch(letter, TouchPhase.ENDED);
        if (touch) {
            var index: int = _letters.indexOf(letter);
            _stack.selectLetter(index);
        }
    }
}
}