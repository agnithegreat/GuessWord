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

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _front = new Image(_assets.getTexture("main_GRADUSNIK"));
        addChild(_front);

        _timeBar = new Image(_assets.getTexture("main_time_under"));
        addChild(_timeBar);

        super.initialize();

        addChild(_timeTF);
    }

    override protected function initializeIPad():void {
        _timeBar.x = -9;
        _timeBar.y = 316;

        _timeTF = createTextField(_timeBar.width, _timeBar.height, 24, "00:00");
        _timeTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _timeTF.x = -9;
        _timeTF.y = 316;
    }

    override protected function initializeIPhone():void {
        _timeBar.x = -4;
        _timeBar.y = 132;

        _timeTF = createTextField(_timeBar.width, _timeBar.height, 10, "00:00");
        _timeTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _timeTF.x = -4;
        _timeTF.y = 132;
    }
}
}
