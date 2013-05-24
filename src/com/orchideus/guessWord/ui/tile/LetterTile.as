/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.game.Letter;

import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.AssetManager;

public class LetterTile extends Sprite {

    private var _back: Image;

    private var _up: Texture;
    private var _down: Texture;
    private var _empty: Texture;

    private var _tf: TextField;

    private var _letter: Letter;
    public function get letter():Letter {
        return _letter;
    }

    private var _slot: Boolean;

    public function LetterTile(letter: Letter, assets: AssetManager, slot: Boolean = true) {
        _letter = letter;
        _letter.addEventListener(Letter.UPDATE, handleUpdate);

        _slot = slot;

        _up = assets.getTexture("letter_under_up");
        _down = assets.getTexture("letter_under_down");
        _empty = assets.getTexture("blank_letter_under");

        _back = new Image(_slot ? _empty : _up);
        addChild(_back);

        _tf = new TextField(_back.width, _back.height, "", "Arial", 32, 0x857d59, true);
        _tf.nativeFilters = [new DropShadowFilter(1, 90, 0, 1, 1, 1, 1, 3, true), new GlowFilter(0xFFFFFF, 1, 2, 2, 2, 3)];
        addChild(_tf);

        addEventListener(TouchEvent.TOUCH, handleTouch);
    }

    private function handleUpdate(event: Event):void {
        _tf.text = _letter.letter ? _letter.letter.toUpperCase() : "";
        visible = _slot || _letter.letter;

        if (_slot && !_letter.letter) {
            _back.texture = _empty;
        } else {
            _back.texture = _up;
        }
    }

    private function handleTouch(event: TouchEvent):void {
        if (_tf.text) {
            if (event.getTouch(this, TouchPhase.BEGAN)) {
                _back.texture = _down;
            } else if (event.getTouch(this, TouchPhase.ENDED)) {
                _back.texture = _up;
            }
        }
    }
}
}
