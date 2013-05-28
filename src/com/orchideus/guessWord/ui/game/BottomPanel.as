/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:23
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.game.Word;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class BottomPanel extends Sprite {

    public static const TILE: int = 56;

    public static var lettersOffset: int = 73;

    private var _assets: AssetManager;

    private var _game: Game;

    private var _slots: Vector.<SlotTile>;
    private var _letters: Vector.<LetterTile>;
    private var _container: Sprite;

    public function BottomPanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init(game: Game):void {
        _game = game;
        _game.word.addEventListener(Word.UPDATE, handleUpdate);
        _game.word.addEventListener(Word.ERROR, handleError);

        _container = new Sprite();
        _container.x = stage.stageWidth/2;
        _container.y = 712;
        addChild(_container);

        _slots = new <SlotTile>[];
        for (var i: int = 0; i < _game.word.letters.length; i++) {
            _slots[i] = new SlotTile(_game.word.letters[i], _assets);
            _slots[i].addEventListener(TouchEvent.TOUCH, handleRemoveLetter);
        }

        _letters = new <LetterTile>[];
        for (i = 0; i < _game.stack.letters.length; i++) {
            _letters[i] = new LetterTile(_game.stack.letters[i], _assets);
            _letters[i].addEventListener(TouchEvent.TOUCH, handleSelectLetter);
            _letters[i].x = (i%10)*TILE;
            _letters[i].y = lettersOffset + int(i/10)*TILE;
            _container.addChild(_letters[i]);
        }

        _container.pivotX = _container.width/2;
    }

    private function handleUpdate(event: Event):void {
        for (var i:int = 0; i < _slots.length; i++) {
            if (i < _game.word.length) {
                _slots[i].x = i*TILE+(_container.width-_game.word.length*TILE)/2;
                _container.addChild(_slots[i]);
            } else if (_slots[i].parent) {
                _container.removeChild(_slots[i]);
            }
        }
    }

    private function handleError(event:Event):void {
        Sound.play(Sound.LOSE);
    }

    private function handleSelectLetter(event: TouchEvent):void {
        var letter: LetterTile = event.currentTarget as LetterTile;
        var touch: Touch = event.getTouch(letter, TouchPhase.BEGAN);
        if (touch) {
            var index: int = _letters.indexOf(letter);
            _game.selectLetter(index);
        }
    }

    private function handleRemoveLetter(event: TouchEvent):void {
        var slot: SlotTile = event.currentTarget as SlotTile;
        var touch: Touch = event.getTouch(slot, TouchPhase.BEGAN);
        if (touch) {
            var index: int = _slots.indexOf(slot);
            _game.removeLetter(index);
        }
    }
}
}
