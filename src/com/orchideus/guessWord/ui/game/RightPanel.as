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

import starling.utils.AssetManager;

public class RightPanel extends AbstractView {

    private var _bar: ScoreBar;

    public function RightPanel(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType);
    }

    override protected function initialize():void {
        _bar = new ScoreBar(_assets, _deviceType);
        addChild(_bar);

        super.initialize();
    }

    override protected function initializeIPad():void {
        _bar.x = 693;
        _bar.y = 283;
    }

    override protected function initializeIPhone():void {
        _bar.x = 286;
        _bar.y = 190;
    }
}
}
