/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 29.05.13
 * Time: 14:25
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.game.Letter;

import starling.display.Sprite;
import starling.utils.AssetManager;

public class ErrorView extends Sprite {

    public function ErrorView(letters: String, assets: AssetManager) {
        for (var i:int = 0; i < letters.length; i++) {
            var letter: Letter = new Letter();
            letter.letter = letters.charAt(i);
            var slot: SlotTile = new SlotTile(letter, assets);
            slot.x = i * BottomPanel.TILE;
            addChild(slot);
            letter.mistake();
        }
    }
}
}
