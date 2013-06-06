/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:11
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class BonusTile extends AbstractView {

    public static const USE: String = "use_BonusTile";

    private var _bonus: Bonus;

    private var _back: Button;

    private var _icon: Image;

    private var _text1: TextField;
    private var _text2: TextField;

    private var _moneyIcon: Image;
    private var _price: TextField;

    public function BonusTile(assets: AssetManager, deviceType: DeviceType, bonus: Bonus) {
        _bonus = bonus;

         super(assets, deviceType);
    }

    override protected function initialize():void {
        _back = new Button(_assets.getTexture("main_cheat_btn_up"), "", _assets.getTexture("main_cheat_btn_down"));
        _back.addEventListener(Event.TRIGGERED, handleTriggered);
        addChild(_back);

        _icon = new Image(_assets.getTexture(_bonus.icon));
        _icon.pivotX = _icon.width/2;
        _icon.touchable = false;
        addChild(_icon);

        _text1 = new TextField(_back.width-14, 30, _bonus.text[0], "Arial", 16, 0xFFFFFF, true);
        _text1.touchable = false;
        _text1.vAlign = VAlign.TOP;
        _text1.autoScale = true;
        _text1.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        addChild(_text1);

        _text2 = new TextField(_back.width-14, 30, _bonus.text[1], "Arial", 16, 0xFFFFFF, true);
        _text2.touchable = false;
        _text2.vAlign = VAlign.TOP;
        _text2.autoScale = true;
        _text2.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        addChild(_text2);

        _moneyIcon = new Image(_assets.getTexture("main_coin_ico"));
        _moneyIcon.touchable = false;
        addChild(_moneyIcon);

        _price = new TextField(30, 30, String(_bonus.price), "Arial", 20, 0xFFFFFF, true);
        _price.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _price.touchable = false;
        _price.vAlign = VAlign.TOP;
        _price.hAlign = HAlign.LEFT;
        addChild(_price);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_icon, _back.width/2, -10);

                place(_text1, 7, 67);
                resize(_text1, _back.width-14, 30);
                place(_text2, 7, 67 + _text1.textBounds.height);
                resize(_text2, _back.width-14, 30)

                place(_moneyIcon, 12, 102);
                place(_price, 40, 101);
                resize(_price, 30, 30);
                _price.fontSize = 20;
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_icon, _back.width/2+1, -7);

                place(_text1, 4, 32);
                resize(_text1, _back.width-8, 12);
                place(_text2, 4, 32 + _text1.textBounds.height);
                resize(_text2, _back.width-8, 12);

                place(_moneyIcon, 5, 48);
                place(_price, 18, 47);
                resize(_price, 15, 15);
                _price.fontSize = 10;
                break;
        }
    }

    private function handleTriggered(event: Event):void {
        dispatchEventWith(BonusTile.USE, true, _bonus);
    }
}
}
