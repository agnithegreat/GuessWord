/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 14:46
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.abstract {
import com.orchideus.guessWord.data.DeviceType;

import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class AbstractView extends Sprite {

    protected var _assets: AssetManager;

    protected var _deviceType: DeviceType;

    public function AbstractView(assets: AssetManager, deviceType: DeviceType) {
        _assets = assets;
        _deviceType = deviceType;

        addEventListener(Event.ADDED_TO_STAGE, handleAdded);
    }

    protected function initialize():void {

    }

    private function handleAdded(event: Event):void {
        initialize();
    }

    public function destroy():void {
        _assets = null;
    }
}
}
