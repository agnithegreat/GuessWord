/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;

public class LetterTile extends Sprite {

    private var _back: Image;
    private var _tf: TextField;

    public function LetterTile(texture: Texture) {
        _back = new Image(texture);
        addChild(_back);

        _tf = new TextField(_back.width, _back.height, "", "Arial", 32, 0x5a4844, true);
        addChild(_tf);
    }

    public function setLetter(letter: String):void {
        _tf.text = letter ? letter.toUpperCase() : "";
    }
}
}
