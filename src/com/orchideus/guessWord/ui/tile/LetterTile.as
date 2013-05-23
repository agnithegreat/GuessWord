/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.game.Letter;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

public class LetterTile extends Sprite {

    private var _back: Image;
    private var _tf: TextField;

    private var _letter: Letter;
    public function get letter():Letter {
        return _letter;
    }

    private var _visibleAlways: Boolean;

    public function LetterTile(letter: Letter, texture: Texture, visibleAlways: Boolean = true) {
        _letter = letter;
        _letter.addEventListener(Letter.UPDATE, handleUpdate);

        _visibleAlways = visibleAlways;

        _back = new Image(texture);
        addChild(_back);

        _tf = new TextField(_back.width, _back.height, "", "Arial", 32, 0x5a4844, true);
        addChild(_tf);
    }

    private function handleUpdate(event: Event):void {
        _tf.text = _letter.letter ? _letter.letter.toUpperCase() : "";
        visible = _visibleAlways || _letter.letter;
    }
}
}
