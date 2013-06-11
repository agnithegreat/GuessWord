/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 03.06.13
 * Time: 15:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.preloader {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.text.TextField;
import starling.utils.AssetManager;

public class LanguageTile extends AbstractView {

    private var _lang: Language;
    public function get lang():Language {
        return _lang;
    }

    private var _back: Button;
    private var _text: TextField;
    private var _icon: Image;


    public function LanguageTile(assets: AssetManager, deviceType: DeviceType, lang: Language) {
        _lang = lang;

        super(assets, deviceType);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _back = new Button(_assets.getTexture("preloader_btn_up"), "", _assets.getTexture("preloader_btn_down"));
        addChild(_back);

        _icon = new Image(_assets.getTexture(_lang.icon));
        addChild(_icon);

        super.initialize();

        _text.touchable = false;
        addChild(_text);
    }

    override protected function initializeIPad():void {
        _text = createTextField(_back.width*0.8, _back.height, 26, _lang.title);
        _text.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
        _text.x = 40;

        _icon.x = -10;
        _icon.y = -5;
    }

    override protected function initializeIPhone():void {
        _text = createTextField(_back.width*0.8, _back.height, 10, _lang.title);
        _text.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
        _text.x = 20;

        _icon.x = -5;
        _icon.y = -3;
    }

    override public function destroy():void {
        super.destroy();

        _lang = null;

        removeChild(_back, true);
        _back = null;

        removeChild(_text, true);
        _text = null;

        removeChild(_icon, true);
        _icon = null;
    }
}
}
