/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 9:35
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Image;
import starling.text.TextField;
import starling.utils.AssetManager;

public class ScoreBar extends AbstractView {

    private var _front: Image;

    private var _timeBar: Image;
    private var _timeTF: TextField;

    public function ScoreBar(assets:AssetManager, deviceType:DeviceType) {
        super(assets, deviceType);
    }

    override protected function initialize():void {
        _front = new Image(_assets.getTexture("main_GRADUSNIK"));
        addChild(_front);

        _timeBar = new Image(_assets.getTexture("main_time_under"));
        addChild(_timeBar);

        _timeTF = new TextField(_timeBar.width, _timeBar.height, "00:00", "Arial", 24, 0xFFFFFF, true);
        _timeTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        addChild(_timeTF);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
//                place(_timeBar, 700, 810);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_front, 0, 15);
                place(_timeBar, -4, 147);
                place(_timeTF, -4, 147);
                _timeTF.fontSize = 10;
                break;
        }
    }
}
}
