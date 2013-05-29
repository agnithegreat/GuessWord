/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Letter;

import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.AssetManager;

public class LetterTile extends Sprite {

    public static const MOVE_FROM:String = "move_from";
    public static const MOVE_TO:String = "move_to";

    private var _up: Texture;
    private var _down: Texture;
    private var _mistake: Texture;

    private var _back: Image;

    private var _tf: TextField;

    private var _letter: Letter;
    public function get letter():Letter {
        return _letter;
    }

    public function LetterTile(letter: Letter, assets: AssetManager) {
        _letter = letter;
        _letter.addEventListener(Letter.UPDATE, handleUpdate);
        _letter.addEventListener(Letter.MISTAKE, handleMistake);

        _up = assets.getTexture("letter_under_up");
        _down = assets.getTexture("letter_under_down");
        _mistake = assets.getTexture("mistake_letter_under");

        _back = new Image(_up);
        addChild(_back);

        _tf = new TextField(width, height, "", "Arial", 32, 0x857d59, true);
        _tf.nativeFilters = [new GlowFilter(0xFFFFFF, 1, 1, 1, 3, 3), new DropShadowFilter(2, 90, 0, 0.75, 2, 2, 3, 3, true), new DropShadowFilter(2, 90, 0xFFFFFF, 1, 1, 1, 3, 3)];
        addChild(_tf);

        addEventListener(TouchEvent.TOUCH, handleTouch);

        update();
    }

    public function update():void {
        _tf.text = _letter.letter ? _letter.letter.toUpperCase() : "";
        visible = _tf.text;

        _back.texture = _up;
    }

    private function handleTouch(event: TouchEvent):void {
        if (event.getTouch(this, TouchPhase.BEGAN)) {
            Sound.play(Sound.CLICK);
        }
    }

    private function handleUpdate(event: Event):void {
//        update();
        if (_letter.letter) {
            dispatchEventWith(MOVE_TO, true);
        } else {
            dispatchEventWith(MOVE_FROM, true);
        }
    }

    private function handleMistake(event: Event):void {
        _back.texture = _mistake;
    }
}
}
