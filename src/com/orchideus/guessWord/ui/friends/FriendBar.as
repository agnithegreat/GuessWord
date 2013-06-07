/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:33
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.friends {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import starling.display.Sprite;
import starling.utils.AssetManager;

public class FriendBar extends AbstractView {

    private var _container: Sprite;

    public function FriendBar(assets:AssetManager, deviceType:DeviceType) {
        super(assets, deviceType);
    }

    override protected function initialize():void {

    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                break;
        }
    }
}
}
