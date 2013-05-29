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

import flash.geom.Point;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.display.Button;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class BottomPanel extends Sprite {

    public static const TILE: int = 56;

    private var _assets: AssetManager;

    private var _game: Game;

    private var _slots: Vector.<SlotTile>;
    private var _slotsContainer: Sprite;

    private var _letters: Vector.<LetterTile>;
    private var _lettersContainer: Sprite;

    private var _error: ErrorView;

    private var _deleteBtn: Button;
    private var _soundBtn: Button;

    public function BottomPanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init(game: Game):void {
        _game = game;
        _game.addEventListener(Game.RESET, handleReset);

        _game.word.addEventListener(Word.UPDATE, handleUpdate);
        _game.word.addEventListener(Word.ERROR, handleError);

        _slotsContainer = new Sprite();
        _slotsContainer.x = stage.stageWidth/2;
        _slotsContainer.y = 712;
        addChild(_slotsContainer);

        _slots = new <SlotTile>[];
        for (var i: int = 0; i < _game.word.letters.length; i++) {
            _slots[i] = new SlotTile(_game.word.letters[i], _assets);
            _slots[i].addEventListener(TouchEvent.TOUCH, handleRemoveLetter);
        }

        _lettersContainer = new Sprite();
        _lettersContainer.x = stage.stageWidth/2;
        _lettersContainer.y = 785;
        addChild(_lettersContainer);

        _letters = new <LetterTile>[];
        for (i = 0; i < _game.stack.letters.length; i++) {
            _letters[i] = new LetterTile(_game.stack.letters[i], _assets);
            _letters[i].addEventListener(TouchEvent.TOUCH, handleSelectLetter);
            _letters[i].x = (i%10)*TILE;
            _letters[i].y = int(i/10)*TILE;
            _lettersContainer.addChild(_letters[i]);
        }

        _lettersContainer.pivotX = _lettersContainer.width/2;

        _error = new ErrorView("ОШИБКА", _assets);
        _error.x = stage.stageWidth/2;
        _error.y = 712;
        _error.pivotX = _error.width/2;
        _error.visible = false;
        addChild(_error);

        addEventListener(LetterTile.MOVE_FROM, handleMoveFrom);
        addEventListener(LetterTile.MOVE_TO, handleMoveTo);

        _deleteBtn = new Button(_assets.getTexture("delete_btn_down"), "", _assets.getTexture("delete_btn_up"));
        _deleteBtn.addEventListener(Event.TRIGGERED, handleDelete);
        _deleteBtn.x = 680;
        _deleteBtn.y = 705;
        addChild(_deleteBtn);

        _soundBtn = new Button(_assets.getTexture("sound_btn_down"), "", _assets.getTexture("sound_btn_up"));
        _soundBtn.addEventListener(Event.TRIGGERED, handleSound);
        _soundBtn.x = 700;
        _soundBtn.y = 810;
        addChild(_soundBtn);
    }

    private function handleUpdate(event: Event):void {
        for (var i:int = 0; i < _slots.length; i++) {
            if (i < _game.word.length) {
                _slots[i].x = i*TILE;
                _slotsContainer.addChild(_slots[i]);
            } else if (_slots[i].parent) {
                _slotsContainer.removeChild(_slots[i]);
            }
        }

        _slotsContainer.pivotX = _slotsContainer.width/2;
    }

    private function handleError(event:Event):void {
        _error.visible = true;
        _slotsContainer.visible = false;
        _deleteBtn.visible = false;

        Sound.play(Sound.LOSE);
    }

    private function handleReset(event: Event):void {
        _error.visible = false;
        _slotsContainer.visible = true;
        _deleteBtn.visible = true;
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

    private var _from: LetterTile;
    private var _to: LetterTile;
    private function handleMoveFrom(event: Event):void {
        _from = event.target as LetterTile;
    }

    private function handleMoveTo(event:Event):void {
        _to = event.target as LetterTile;
        if (_from) {
            createPhantom(_from, _to);
            _from = null;
            _to = null;
        } else {
            _to.update();
            _to = null;
        }
    }

    private function createPhantom(from: LetterTile, to: LetterTile):void {
        var fromPos: Rectangle = from.getBounds(this);
        var toPos: Rectangle = to.getBounds(this);

        var phantom: LetterTile = new LetterTile(to.letter, _assets);
        phantom.x = fromPos.x;
        phantom.y = fromPos.y
        addChild(phantom);

        from.visible = false;

        Starling.juggler.tween(phantom, 0.3, {x: toPos.x, y: toPos.y, onComplete: handleAnimate, onCompleteArgs: [phantom, to]});
    }

    private function handleAnimate(phantom: LetterTile, to: LetterTile):void {
        removeChild(phantom);
        to.update();
    }

    private function handleDelete(event: Event):void {
        Sound.play(Sound.BACKSPACE);

        _game.reset();
    }

    private function handleSound(event: Event):void {
        Sound.play(Sound.CLICK);

        Sound.enabled = !Sound.enabled;

        // TODO: добавить стейты
        _soundBtn.downState = _assets.getTexture("sound_btn_down");
        _soundBtn.upState = _assets.getTexture("sound_btn_up");
    }
}
}
