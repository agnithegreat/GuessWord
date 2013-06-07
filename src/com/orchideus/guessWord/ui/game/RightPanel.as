/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 9:32
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import starling.display.Image;

import starling.utils.AssetManager;

public class RightPanel extends AbstractView {

    private var _bar: ScoreBar;

    public function RightPanel(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType);
    }

    override protected function initialize():void {
        _bar = new ScoreBar(_assets, _deviceType);
        addChild(_bar);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
//                place(_bar, 700, 810);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_bar, 286, 175);
                break;
        }
    }
}
}
