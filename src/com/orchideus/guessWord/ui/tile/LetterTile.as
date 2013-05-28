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
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class LetterTile extends Button {

    private var _tf: TextField;

    private var _letter: Letter;
    public function get letter():Letter {
        return _letter;
    }

    public function LetterTile(letter: Letter, assets: AssetManager) {
        super(assets.getTexture("letter_under_up"), "", assets.getTexture("letter_under_down"));

        _letter = letter;
        _letter.addEventListener(Letter.UPDATE, handleUpdate);

        _tf = new TextField(width, height, "", "Arial", 32, 0x857d59, true);
        _tf.nativeFilters = [new GlowFilter(0xFFFFFF, 1, 1, 1, 3, 3), new DropShadowFilter(2, 90, 0, 0.75, 2, 2, 3, 3, true), new DropShadowFilter(2, 90, 0xFFFFFF, 1, 1, 1, 3, 3)];
        addChild(_tf);

        addEventListener(Event.TRIGGERED, handleClick);

        update();
    }

    public function update():void {
        _tf.text = _letter.letter ? _letter.letter.toUpperCase() : "";
        visible = _tf.text;
    }

    private function handleUpdate(event: Event):void {
        update();
//        if (_letter.letter) {
//            dispatchEventWith(MOVE_TO, true, update);
//        } else {
//            dispatchEventWith(MOVE_FROM, true, update);
//        }
    }

    private function handleClick(event: Event):void {
        Sound.play(Sound.CLICK);
    }
}
}
