/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:23
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.game.Letter;
import com.orchideus.guessWord.game.Word;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.LetterTile;

import flash.geom.Rectangle;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.utils.AssetManager;

public class BottomPanel extends AbstractView {

    public static var TILE: int = 56;

    private var _game: Game;

    private var _slots: Vector.<SlotTile>;
    private var _slotsContainer: Sprite;

    private var _letters: Vector.<LetterTile>;
    private var _lettersContainer: Sprite;

    private var _error: ErrorView;

    private var _deleteBtn: Button;

    public function BottomPanel(assets: AssetManager, deviceType: DeviceType, game: Game) {
        _game = game;
        _game.addEventListener(Game.INIT, handleInit);
        _game.addEventListener(Game.RESET, handleReset);
        _game.addEventListener(Game.WIN, handleWin);

        _game.word.addEventListener(Word.ERROR, handleError);
        _game.word.addEventListener(Word.CLEAR, handleClear);

        super(assets, deviceType)
    }

    override protected function initialize():void {
        _slotsContainer = new Sprite();
        addChild(_slotsContainer);

        var texture: Texture = _assets.getTexture("main_letter_under");
        TILE = texture.width*0.94;

        _error = new ErrorView(_assets, _deviceType, "ОШИБКА");
        addChild(_error);
        _error.pivotX = _error.width/2;
        _error.visible = false;

        _lettersContainer = new Sprite();
        addChild(_lettersContainer);

        _letters = new <LetterTile>[];
        for (var i: int = 0; i < _game.stack.letters.length; i++) {
            var letter: LetterTile = new LetterTile(_assets, _deviceType, _game.stack.letters[i]);
            letter.addEventListener(TouchEvent.TOUCH, handleSelectLetter);
            letter.x = (i%10)*TILE;
            letter.y = int(i/10)*TILE;
            _lettersContainer.addChild(letter);
            _letters[i] = letter;
        }

        _lettersContainer.pivotX = _lettersContainer.width/2;

        addEventListener(LetterTile.MOVE_FROM, handleMoveFrom);
        addEventListener(LetterTile.MOVE_TO, handleMoveTo);

        _deleteBtn = new Button(_assets.getTexture("main_del_btn_down"), "", _assets.getTexture("main_del_btn_up"));
        _deleteBtn.addEventListener(Event.TRIGGERED, handleDelete);
        addChild(_deleteBtn);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_slotsContainer, stage.stageWidth/2, 712);
                place(_error, stage.stageWidth/2, 712);
                place(_lettersContainer, stage.stageWidth/2, 785);
                place(_deleteBtn, 680, 705);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_slotsContainer, stage.stageWidth/2, 373);
                place(_error, stage.stageWidth/2, 373);
                place(_lettersContainer, stage.stageWidth/2, 410);
                place(_deleteBtn, 225, 330);
                break;
        }
    }

    private function handleInit(event: Event):void {
        _slots = new <SlotTile>[];
        for (var i: int = 0; i < _game.word.length; i++) {
            var letter: Letter = _game.word.letters[i];
            _slots[i] = new SlotTile(_assets, _deviceType, letter);
            _slots[i].addEventListener(TouchEvent.TOUCH, handleRemoveLetter);
            _slots[i].x = i*TILE;
            _slotsContainer.addChild(_slots[i]);
        }

        _slotsContainer.pivotX = _slotsContainer.width/2;
    }

    private function handleWin(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.WIN);
    }

    private function handleError(event:Event):void {
        _error.visible = true;
        _slotsContainer.visible = false;
        _deleteBtn.visible = false;

        dispatchEventWith(Sound.SOUND, true, Sound.LOSE);
    }

    private function handleClear(event: Event):void {
        for (var i: int = 0; i < _slots.length; i++) {
            _slots[i].removeEventListener(TouchEvent.TOUCH, handleRemoveLetter);
            _slots[i].destroy();
        }
        _slotsContainer.removeChildren();

        _from = null;
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
        _from.visible = false;
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

        var phantom: LetterTile = new LetterTile(_assets, _deviceType, to.letter);
        phantom.x = fromPos.x;
        phantom.y = fromPos.y
        addChild(phantom);

        Starling.juggler.tween(phantom, 0.1, {x: toPos.x, y: toPos.y, onComplete: handleAnimate, onCompleteArgs: [phantom, to]});
    }

    private function handleAnimate(phantom: LetterTile, to: LetterTile):void {
        removeChild(phantom);
        to.update();
    }

    private function handleDelete(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.BACKSPACE);

        _game.reset();
    }
}
}
