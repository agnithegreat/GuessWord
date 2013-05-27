/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:18
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import starling.display.Image;
import starling.utils.AssetManager;

public class SlotTile extends Image {

    public function SlotTile(assets: AssetManager) {
        super(assets.getTexture("blank_letter_under"));
    }
}
}
