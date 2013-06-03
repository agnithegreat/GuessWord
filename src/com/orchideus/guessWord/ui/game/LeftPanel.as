/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:25
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.ui.tile.BonusTile;

import starling.display.Sprite;
import starling.utils.AssetManager;

public class LeftPanel extends Sprite {

    private var _assets: AssetManager;

    private var _openLetter: BonusTile;
    private var _removeLetters: BonusTile;
    private var _changePic: BonusTile;
    private var _removePic: BonusTile;

    public function LeftPanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init():void {
        _openLetter = new BonusTile(Bonus.BONUSES[Bonus.OPEN_LETTER], _assets);
        _openLetter.x = 4;
        _openLetter.y = 105;
        addChild(_openLetter);

        _removeLetters = new BonusTile(Bonus.BONUSES[Bonus.REMOVE_LETTERS], _assets);
        _removeLetters.x = 4;
        _removeLetters.y = 256;
        addChild(_removeLetters);

        _changePic = new BonusTile(Bonus.BONUSES[Bonus.CHANGE_PICTURE], _assets);
        _changePic.x = 4;
        _changePic.y = 409;
        addChild(_changePic);

        _removePic = new BonusTile(Bonus.BONUSES[Bonus.REMOVE_WRONG_PICTURE], _assets);
        _removePic.x = 4;
        _removePic.y = 562;
        addChild(_removePic);
    }
}
}
