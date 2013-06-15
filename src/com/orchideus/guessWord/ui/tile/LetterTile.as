/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Letter;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;

import starling.display.Image;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

public class LetterTile extends AbstractView {

    public static const MOVE_FROM:String = "move_from";
    public static const MOVE_TO:String = "move_to";

    private var _up: Texture;
    private var _down: Texture;
    private var _mistake: Texture;

    private var _back: Image;

    private var _tf: TextField;
    private var _tfFilters: Array;

    private var _letter: Letter;
    public function get letter():Letter {
        return _letter;
    }

    public function LetterTile(refs: CommonRefs, letter: Letter) {
        _letter = letter;
        _letter.addEventListener(Letter.UPDATE, handleUpdate);
        _letter.addEventListener(Letter.MISTAKE, handleMistake);

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _up = _refs.assets.getTexture("main_letter_under");
        _down = _refs.assets.getTexture("main_letter_under_down");
        _mistake = _refs.assets.getTexture("main_mistake_btn_under");

        _back = new Image(_up);
        addChild(_back);

        super.initialize();

        _tf.touchable = false;
        addChild(_tf);

        addEventListener(TouchEvent.TOUCH, handleTouch);

        update();
    }

    override protected function initializeIPhone():void {
        _tf = createTextField(width, height, 36, "", 0x857d59);
        _tfFilters = [new GlowFilter(0xFFFFFF, 1, 1, 1, 3, 3),
                             new DropShadowFilter(2, 90, 0, 0.75, 2, 2, 3, 3, true),
                             new DropShadowFilter(2, 90, 0xFFFFFF, 1, 1, 1, 3, 3)];
    }

    override protected function applyFilters():void {
        _tf.nativeFilters = _tfFilters;
    }

    public function update():void {
        _tf.text = _letter.letter ? _letter.letter.toUpperCase() : "";
        visible = Boolean(_tf.text);

        _back.texture = _up;
    }

    private function handleTouch(event: TouchEvent):void {
        if (event.getTouch(this, TouchPhase.BEGAN)) {
            dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        }
    }

    private function handleUpdate(event: Event):void {
        if (event.data) {
            if (_letter.letter) {
                dispatchEventWith(MOVE_TO, true);
            } else {
                dispatchEventWith(MOVE_FROM, true);
            }
        } else {
            update();
        }
    }

    private function handleMistake(event: Event):void {
        _back.texture = _mistake;
    }

    override public function destroy():void {
        removeEventListeners();

        _up.dispose();
        _down.dispose();
        _mistake.dispose();

        removeChild(_back, true);
        removeChild(_tf, true);

        _letter.removeEventListeners();
        _letter = null;
    }
}
}
