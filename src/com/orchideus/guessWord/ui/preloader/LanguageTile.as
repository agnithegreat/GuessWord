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

    private var _id: int;

    private var _lang: Language;
    public function get lang():Language {
        return _lang;
    }

    private var _back: Button;
    private var _text: TextField;
    private var _icon: Image;


    public function LanguageTile(id: int, lang: Language, assets: AssetManager, deviceType: DeviceType) {
        _id = id;
        _lang = lang;

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _back = new Button(_assets.getTexture("preloader_btn_up"), "", _assets.getTexture("preloader_btn_down"));
        addChild(_back);

        _text = new TextField(_back.width*0.8, _back.height, _lang.title, "Arial", 26, 0xFFFFFF, true);
        _text.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
        addChild(_text);

        _icon = new Image(_assets.getTexture(_lang.icon));
        addChild(_icon);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(this, _id<6 ? (_id%3) * 255 : 255, int(_id/3) * 85);
                place(_text, 40, 0);
                _text.fontSize = 26;
                place(_icon, -10, -5);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(this, _id<6 ? (_id%3) * 105 : 105, int(_id/3) * 35);
                place(_text, 20, 0);
                _text.fontSize = 10;
                place(_icon, -5, -3);
                break;
        }
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
