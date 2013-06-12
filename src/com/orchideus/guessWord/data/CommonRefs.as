/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 10:26
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import com.orchideus.guessWord.localization.LocalizationManager;

import starling.utils.AssetManager;

public class CommonRefs {

    private var _assets: AssetManager;
    public function get assets():AssetManager {
        return _assets;
    }

    private var _device: DeviceType;
    public function get device():DeviceType {
        return _device;
    }

    private var _locale: LocalizationManager;
    public function get locale():LocalizationManager {
        return _locale;
    }

    public function CommonRefs(assets: AssetManager, device: DeviceType, locale: LocalizationManager) {
        _assets = assets;
        _device = device;
        _locale = locale;
    }
}
}
