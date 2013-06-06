/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:25
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.BonusTile;

import starling.utils.AssetManager;

public class LeftPanel extends AbstractView {

    private var _openLetter: BonusTile;
    private var _removeLetters: BonusTile;
    private var _changePic: BonusTile;
    private var _removePic: BonusTile;

    public function LeftPanel(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType)
    }

    override protected function initialize():void {
        _openLetter = new BonusTile(_assets, _deviceType, Bonus.BONUSES[Bonus.OPEN_LETTER]);
        addChild(_openLetter);

        _removeLetters = new BonusTile(_assets, _deviceType, Bonus.BONUSES[Bonus.REMOVE_LETTERS]);
        addChild(_removeLetters);

        _changePic = new BonusTile(_assets, _deviceType, Bonus.BONUSES[Bonus.CHANGE_PICTURE]);
        addChild(_changePic);

        // TODO: отображать только если есть лишняя
        _removePic = new BonusTile(_assets, _deviceType, Bonus.BONUSES[Bonus.REMOVE_WRONG_PICTURE]);
        addChild(_removePic);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_openLetter, 4, 105);
                place(_removeLetters, 4, 256);
                place(_changePic, 4, 409);
                place(_removePic, 4, 562);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_openLetter, 1, 88);
                place(_removeLetters, 1, 158);
                place(_changePic, 1, 228);
                place(_removePic, 1, 298);
                break;
        }
    }
}
}
