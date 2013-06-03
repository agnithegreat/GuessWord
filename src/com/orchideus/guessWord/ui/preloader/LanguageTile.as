/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 03.06.13
 * Time: 15:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.preloader {
import flash.filters.GlowFilter;

import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.AssetManager;

public class LanguageTile extends Sprite {

    private var _locale: String;
    public function get locale():String {
        return _locale;
    }

    private var _assets: AssetManager;

    private var _back: Image;
    private var _text: TextField;
    private var _icon: Image;

    public function LanguageTile(locale: String, icon: String, assets: AssetManager) {
        _locale = locale;
        _assets = assets;

        _back = new Image(_assets.getTexture("lang_btn"));
        addChild(_back);

        _text = new TextField(_back.width-40, _back.height, locale, "Arial", 26, 0xFFFFFF, true);
        _text.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
        _text.x = 40;
        addChild(_text);

        _icon = new Image(_assets.getTexture(icon));
        _icon.x = -10;
        _icon.y = -5;
        addChild(_icon);
    }
}
}
