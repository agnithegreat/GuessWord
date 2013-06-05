/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 13:06
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.abstract {
import com.orchideus.guessWord.data.DeviceType;

import starling.display.Image;
import starling.utils.AssetManager;

public class Screen extends AbstractView {

    protected var _background: Image;

    public function Screen(assets: AssetManager, deviceType: DeviceType, background: String = null) {
        super(assets, deviceType);

        if (background) {
            _background = new Image(_assets.getTexture(background));
            addChild(_background);
        }
    }

    override public function destroy():void {
        super.destroy();

        if (_background) {
            removeChild(_background, true);
            _background = null;
        }
    }
}
}
