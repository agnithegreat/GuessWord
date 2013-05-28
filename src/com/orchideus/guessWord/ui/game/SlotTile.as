/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:18
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.game.Letter;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Image;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class SlotTile extends Sprite {

    private var _back: Image;

    private var _letter: LetterTile;

    public function SlotTile(letter: Letter, assets: AssetManager) {
        _back = new Image(assets.getTexture("blank_letter_under"));
        addChild(_back);

        _letter = new LetterTile(letter, assets);
        addChild(_letter);
    }
}
}
